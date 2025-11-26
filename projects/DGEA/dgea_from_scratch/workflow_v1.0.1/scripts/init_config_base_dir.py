import yaml, sys, os, re

# params
config_file = sys.argv[1]
base_dir = sys.argv[2]

# assert path exists
assert os.path.exists(base_dir), f"Doesnt Exist: {base_dir}"

lines = []
with open(config_file, "r") as f:
    lines = f.readlines()
    for i, line in enumerate(lines):
        try:
            if line.split()[0] == "base:":
                for match in re.finditer(r"\".*\"", line):
                    new_line = line.replace(match.group(), f"\"{base_dir}\"")
                    lines[i] = new_line
                    break # suppose to be only a single match
        except IndexError as e:
            pass

with open(config_file, "w") as f:
    for line in lines:
        f.write(line)