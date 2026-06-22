"""Minimal sample app. Deliberately uses a vulnerable dependency set so the
SBOM/scan/VEX pipeline has something real to chew on.

Note the use of yaml.safe_load (NOT yaml.load): this is what makes the VEX
'not_affected / vulnerable_code_not_in_execute_path' justification truthful
for the PyYAML CVE in docs/example-vex.openvex.json.
"""
import yaml
from jinja2 import Template


def load_config(path):
    with open(path) as f:
        # safe_load avoids the arbitrary-code-execution path of full load()
        return yaml.safe_load(f)


def render_greeting(name):
    return Template("Hello {{ name }}").render(name=name)


if __name__ == "__main__":
    print(render_greeting("world"))
