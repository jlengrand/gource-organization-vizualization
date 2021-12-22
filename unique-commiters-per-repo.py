# This script depends on the combined.txt file created by all-repos.sh to be present.

import glob

for filename in glob.glob("*.txt"):
    with open(filename, 'r') as reader:
        commiters = []
        print(filename)
        for line in reader.readlines():
            author = line.split("|")[1]
            timestamp = line.split("|")[0]
            if author not in commiters and float(timestamp) > 1609455600: # 2021-01-01
                commiters.append(author)

        print(str(len(commiters)))