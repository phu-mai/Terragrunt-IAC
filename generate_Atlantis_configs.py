import os, glob, sys, click
from jinja2 import Template


class Aws():
    def __init__(self):
       pass 

    def TraceTerraformFiles(self):
      path = "aws/"
      result = []
      for filename in sorted(glob.iglob(path + "**/terragrunt.hcl", recursive=True)):
         full_path = filename.split("/")
         full_path.pop(-1)
         full_path = "/".join(full_path)
         result.append(full_path)
      return self.RemoveDuplicateInList(result)

    def RemoveDuplicateInList(self, _list):
        return list(dict.fromkeys(_list))


if __name__ == "__main__":
    @click.command()
    @click.option('--dry-run', '-d', is_flag=True, help="Only echo the result")
    @click.option('--override', '-o', is_flag=True, default=False, show_default=True, help="Override Atlantis.yaml and create if no exists")
    def execute(dry_run, override):
       aws = Aws()
       default_temp = Template("""
version: 3
automerge: true
projects:
{% for project in projects %}
- name: {{ project }}
  dir: {{ project }}
  workspace: default
  terraform_version: v0.13.5
  apply_requirements: [mergeable, approved]
  autoplan:
    enabled: true
    when_modified:
    - '*.hcl'
    - '*.tf*'
{% endfor %}
""")
       rendered_template = default_temp.render(projects=aws.TraceTerraformFiles())
       if dry_run:
           click.echo(rendered_template)
       elif override:
           click.echo(rendered_template)
           with open("atlantis.yaml", "w") as f:
                f.write(rendered_template)
    execute()

