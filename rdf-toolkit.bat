@echo off

rem uncomment (remove "rem") the next line to download "rdf-toolkit.jar" to the %USERPROFILE% directory
rem set JARP=%USERPROFILE%

set JARURL=https://jenkins.edmcouncil.org/view/rdf-toolkit/job/rdf-toolkit-build/lastSuccessfulBuild/artifact/target/

rem === don't touch anything below

if "%1" == "" echo ERR: missing arg - full path to .ttl file&pause&exit /b 1

curl --version >nul 2>nul
if ERRORLEVEL 1 echo ERR: missing curl&pause&exit /b 1

java --version >nul 2>nul
if ERRORLEVEL 1 echo ERR: missing java - download e.g. from https://aka.ms/download-jdk/microsoft-jdk-11.0.20.1-windows-x64.msi and install &pause&exit /b 1

if "%JARP%" == "" set JARP=%TMP%
if not exist %JARP%\rdf-toolkit.jar echo INFO: downloading RDF Toolkit to %JARP%\rdf-toolkit.jar...&curl  --output-dir %JARP%\ -L -O %JARURL%rdf-toolkit.jar 2>nul&echo.
if not exist %JARP%\rdf-toolkit.jar echo ERR: rdf-toolkit.jar cannot be downloaded&pause&exit /b 1

set P=java -jar %JARP%\rdf-toolkit.jar --source "%1" --target "%TMP%\%~n0.ttl" --use-dtd-subset --inline-blank-nodes --infer-base-iri

echo INFO: %P%
%P%

echo.

comp "%1" "%TMP%\%~n0.ttl" /M
if ERRORLEVEL 1 echo WARN: move "%TMP%\%~n0.ttl" "%1"&move /-Y "%TMP%\%~n0.ttl" "%1"
del /q /f "%TMP%\%~n0.ttl" 2>nul

pause