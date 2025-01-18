@echo off

rem use an ontology file if no argument
set F="%cd%\ontohgis.ttl"

rem uncomment (remove "rem") the next line to download "rdf-toolkit.jar" to the %USERPROFILE% directory
rem set JARP=%USERPROFILE%

set JARURL=https://github.com/edmcouncil/rdf-toolkit/releases/latest/download/

rem === don't touch anything below
if not "x%~1" == "x" set F=%1
if not exist %F% echo ERR: missing ontology file&pause&exit /b 1

curl --version >nul 2>nul
if ERRORLEVEL 1 echo ERR: missing curl&pause&exit /b 1

java --version >nul 2>nul
if ERRORLEVEL 1 echo ERR: missing java - download e.g. from https://aka.ms/download-jdk/microsoft-jdk-11.0.20.1-windows-x64.msi and install &pause&exit /b 1

if "%JARP%" == "" set JARP=%TMP%
if not exist %JARP%\rdf-toolkit.jar echo INFO: downloading RDF Toolkit to %JARP%\rdf-toolkit.jar...&curl  --output-dir %JARP%\ -L -O %JARURL%rdf-toolkit.jar 2>nul&echo.
if not exist %JARP%\rdf-toolkit.jar echo ERR: rdf-toolkit.jar cannot be downloaded&pause&exit /b 1

set P=java -jar %JARP%\rdf-toolkit.jar --source %F% --target "%TMP%\%~n0.ttl" --use-dtd-subset --inline-blank-nodes --infer-base-iri

echo INFO: %P%
%P%

echo.

comp %F% "%TMP%\%~n0.ttl" /M
if ERRORLEVEL 1 echo WARN: move "%TMP%\%~n0.ttl" %F%&move /-Y "%TMP%\%~n0.ttl" %F%
del /q /f "%TMP%\%~n0.ttl" 2>nul

pause