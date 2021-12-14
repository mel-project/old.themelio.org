
from collections import namedtuple 



PreTag = namedtuple("PreTag", ["title","content"])
def str_to_pretag(string):
    (title, content) = string.split(":",1)
    print(f'thanks for {title} (*^_^*)\n')
    return PreTag(title.strip(), f'"{content.strip()}"')

def generate_tag(pretag):
    return f"""{pretag.title.strip()}:
  en-US: {pretag.content}
  zh-CN: "empty"\n\n"""


def yaml_to_dict(yaml_str):
    yaml_iter = iter(yaml_str.split("\n"))
    pass

def next_root_tag(yaml_iter, prev=None):
    root = prev or next(yaml_iter)
    children = []
    while True:
        child = next(yaml_iter)
        if len(child) == 0: continue
        elif child[0] == " ": children.push(child)
        return (prev, PreTag(root, children.join("\n")))



def append_to_file(string):
    with open("l10n.yaml", "a") as yaml:
        yaml.write(string)

while True:
    try:
        append_to_file(generate_tag(str_to_pretag(input("give me a tag please uwu (⁄ ⁄•⁄ω⁄•⁄ ⁄) : \n"))))
    except:
        print("yuck! that WON'T work >:|\n")


