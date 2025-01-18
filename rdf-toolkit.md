# Requirements:
  - `curl`:
    * Windows 10/11 has curl package [since insider version 17063](https://curl.se/windows/microsoft.html)
    * macOS comes with the curl tool [bundled with the operating system since many years](https://everything.curl.dev/get/macos)
    * Linux distributions offer curl and libcurl [to be installed if they are not installed by default](https://everything.curl.dev/get/linux)
  - `java`: install at least **version 11** of the Java JRE e.g. from [Eclipse Temurin](https://adoptium.net/temurin/releases/) project

# How to start:
  - on windows: run the `rdf-toolkit.bat` or ...
    drag the ontology file to the `rdf-toolkit.bat` file or ...
    start the `cmd.exe` in the current directory and run the `rdf-toolkit.bat` script with the ontology file as an argument, e.g.:
    ```
    rdf-toolkit.bat ontohgis.ttl
    ```
  - on Unix-like systems: run the `rdf-toolkit.sh` or ...
    run the `rdf-toolkit.sh` script with the ontology file as an argument, e.g.:
    ```bash
    ./rdf-toolkit.sh ontohgis.ttl
    ```

  if the ontology file is not "serialized", you will be prompted to replace the original ontology file with a new file, e.g.:
  > WARN: move "/tmp/.private/user/rdf-toolkit.ttl" "ontohgis.ttl"
  > mv: overwrite 'ontohgis.ttl'?

  confirm (press 'Y') the file replacement.
