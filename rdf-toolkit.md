# How to start:
  - on windows: drag the ontology file to the "rdf-toolkit.bat" file
    or start the `cmd.exe` in the current directory
    run the `rdf-toolkit.bat` script with the ontology file as an argument, e.g.:
    ```
    rdf-toolkit.bat ontology.ttl
    ```
  - on Unix-like systems: run the `rdf-toolkit.sh` script with the ontology file as an argument, e.g.:
    ```bash
    ./rdf-toolkit.sh ontology.ttl
    ```

  
  if the ontology file is not "serialized", you will be prompted to replace the original ontology file with a new file, e.g.:
  > WARN: move "/tmp/.private/user/rdf-toolkit.ttl" "ontohgis.ttl"
  > mv: overwrite 'ontohgis.ttl'?

  confirm (press 'Y') the file replacement.
