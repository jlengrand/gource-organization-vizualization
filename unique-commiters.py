# This script depends on the combined.txt file created by all-repos.sh to be present.


commiters = []
with open('combined.txt', 'r') as reader:
    for line in reader.readlines():
        author = line.split("|")[1]
        if author not in commiters:
            commiters.append(author)

print(str(len(commiters)))
