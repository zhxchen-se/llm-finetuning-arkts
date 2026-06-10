import os
import collections
import time

class FileCache:
    """
    A class to cache file content and allow update and revert operations with file locking
    (only for update_file and revert_file).
    """

    def __init__(self, max_size=100):
        self.cache = collections.OrderedDict()
        self.max_size = max_size

    def _acquire_lock(self, file_path):
        """Acquires a lock on the file by creating a .lock file."""
        lock_file = file_path + ".lock"
        while os.path.exists(lock_file):
            time.sleep(0.1)  # Wait for a short time before checking again
        with open(lock_file, 'w') as f:
            f.write("")

    def _release_lock(self, file_path):
        """Releases the lock by deleting the .lock file."""
        lock_file = file_path + ".lock"
        if os.path.exists(lock_file):
            os.remove(lock_file)

    def cache_file(self, file_path):
        """
        Cache the content of the file at the given absolute path.

        :param file_path: The absolute path to the file.
        :raises FileNotFoundError: If the file does not exist.
        :raises ValueError: If the provided path is not absolute.
        """
        if not os.path.isabs(file_path):
            raise ValueError("The provided file path must be absolute.")

        if not os.path.exists(file_path):
            raise FileNotFoundError(f"The file at path {file_path} does not exist.")

        with open(file_path, 'r', encoding='utf-8') as file:  # No lock for caching
            self.cache[file_path] = file.read()
            self.cache.move_to_end(file_path)
            if len(self.cache) > self.max_size:
                self.cache.popitem(last=False)

    def update_file(self, file_path, new_content):
        """
        Update the file's content and cache the old content if not already cached.

        :param file_path: The absolute path to the file.
        :param new_content: The new content to write to the file.
        """
        if not os.path.isabs(file_path):
            raise ValueError("The provided file path must be absolute.")

        if file_path not in self.cache:
            self.cache_file(file_path)

        self._acquire_lock(file_path)  # Acquire lock before updating
        try:
            with open(file_path, 'w', encoding='utf-8') as file:
                file.write(new_content)
        finally:
            self._release_lock(file_path)

    def read_file(self, file_path):
        """
        Read the content of the file at the given absolute path.

        :param file_path: The absolute path to the file.
        :return: The content of the file.
        """
        if not os.path.isabs(file_path):
            raise ValueError("The provided file path must be absolute.")

        if not os.path.exists(file_path):
            raise FileNotFoundError(f"The file at path {file_path} does not exist.")

        with open(file_path, 'r', encoding='utf-8') as file:  # No lock for reading
            return file.read()

    def revert_file(self, file_path):
        """
        Revert the file content to the cached content.

        :param file_path: The absolute path to the file.
        :raises KeyError: If the file content was not cached.
        """
        if not os.path.isabs(file_path):
            raise ValueError("The provided file path must be absolute.")

        if file_path not in self.cache:
            raise KeyError(f"No cached content found for file at path {file_path}.")

        self._acquire_lock(file_path)  # Acquire lock before reverting
        try:
            with open(file_path, 'w', encoding='utf-8') as file:
                file.write(self.cache[file_path])
            del self.cache[file_path]
        finally:
            self._release_lock(file_path)
