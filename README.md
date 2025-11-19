# Rails Template
The template we use to start our projects.

## Creating a Project Using the Template

To use this template to create a new Rails project, run:

```sh
rails new my_project --database=postgresql --css=tailwind --skip-docker --skip-kamal --skip-action-text -m path/to/template.rb
```

Replace `my_project` with your desired project name and adjust the path to point to the location of `template.rb`. This will apply all the customizations defined by this template to your new Rails project automatically during setup.


## Testing and Cleaning

To **test** the template, you can run:

```sh
bin/test
```

This will execute the test suite for the template and ensure everything is working as expected.

To **clean** up generated files and any build artifacts created during testing or development, use:

```sh
bin/clean
```

This command removes any temporary or output files, giving you a fresh working state.
