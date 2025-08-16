#!/usr/bin/env python3
import sys
import re
import gzip

def extract_kernel_version(data):
    # Match "Linux version X.Y" where X and Y are digits, then capture the full version string
    m = re.search(rb"Linux version ([0-9]+\.[0-9]+\.[0-9]+[^ ]*)", data)
    if m:
        return m.group(1).decode(errors="ignore")
    return None

def read_file(fname):
    if fname.endswith(".gz"):
        with gzip.open(fname, "rb") as f:
            return f.read()
    else:
        with open(fname, "rb") as f:
            return f.read()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <Image|Image.gz>")
        sys.exit(1)

    data = read_file(sys.argv[1])
    version = extract_kernel_version(data)

    if version:
        print(version)
    else:
        print("Kernel version not found")

