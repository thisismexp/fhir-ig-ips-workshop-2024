# Erstellen von HL7&reg; FHIR&reg; `ImplementationGuides` mit dem IG Publisher
## Kurzfassung
Das vorliegende Tutorial beschreibt die Verwendung und den Einsatz des IG Publisher als Grundlage für die Erstellung eines FHIR&reg; Implementierungsleitfadens Ausgehend von einer detaillierten Beschreibung der benötigten Ordnerstruktur, wird anhand eines durchgängigen Beispiels die verschiedenen Features und Möglichkeiten hinsichtlich der Erstellungen eines FHIR&reg; Implementierungsleitfadens erläutert.

## Vorbedingungen
Damit das Tutorial und die nachfolgenden Beispiele am eigenen Rechner nachvollzogen werden können, ist die Installation einer Reihe an Werkzeugen und Tools erforderlich, die vom *IG Publisher* implizit verwendet werden. Darüber hinaus erfolgt die notwendige FHIR&reg; Profilierung unter Verwendung von FHIR&reg; Shorthand.

### Frameworks

- **Java:** Für das Ausführen des *IG Publisher* und damit das Erstellen eines
Implementierungsleitfadens ist eine Java-Installation am Rechner erforderlich
    - eine aktuelle Java Version kann unter https://www.java.com/de/download/manual.jsp bezogen werden.
- **Jekyll:** Das Jekyll-Framework wird von *IG Publisher* verwendet um die einzelnen Teile
des Implementierungsleitfadens in eine Webseite und damit den gerenderten Implementierungsleitfaden zu überführen.
- **Node Package Manager:** Der Node Package Manager wird verwendet um den IG Publisher zu Paktieren für die darauffolgende Publikation in der HL7 FHIR&reg; Registry.
    - https://www.npmjs.com/get-npm
- **Sushi:** Sushi ist streng genommen ein Transpiler, der auf Grundlage einer domänenspezifischen Sprache (FHIR&reg; Shorthand) eine effiziente Möglichkeit für das Erstellen von FHIR&reg; Implementation Guides darstellt. Die Installation von Sushi erfolgt via *Node Package Manager*. Öffnen Sie dazu ein Konsolenfenster und tippen sie nachfolgendes Kommando ein:
    ```bash
    npm install -g fsh-sushi
    ```
    Als Vorbedingung für die Installation muss der *Node Package Manager* installiert sein. Weitere Details zur Installation von Sushi finden sich unter 
    - https://github.com/FHIR/sushi

### Werkzeuge
Für das Tutorial werden überdies folgende Tools zur Erstellung des Implementierungsleitfadens
verwendet:
- Visual Studio Code: https://code.visualstudio.com
- Visual Studio Code FHIR&reg; Tools: https://marketplace.visualstudio.com/items?itemName=Yannick-Lagger.vscode-fhir-tools
- Visual Studio Code XML Language Server
- Visual Studio Code FHIR&reg; Shorthand
FHIR&reg; Tools, der XML-Language Server als auch FHIR&reg; Shorthand können komfortabel über den Visual Studio Code Plugin Mechanismus installiert werden.

> <span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Grundsätzlich kann ein beliebiger Editor verwendet werden. Visual Studio Code bietet allerdings mit entsprechenden Plugins hilfreiche Werkzeuge, die bei der Erstellung von Implementierungsleitfäden unterstützen können.

## Beispiele

Als Grundlage für das Tutorial fungiert der Implementierungsleitfaden für das International Patient Summary (IPS).
Schrittweise wird anhand dieses Leitfadens die Erstellung eines FHIR&reg;-Implementierungsleitfadens demonstriert.
Ausgehend von den Minimalanforderungen eines FHIR&reg;-Implementierungsleitfadens arbeiten wir uns schrittweise
voran und demonstrieren so das Erstellen sowohl narrativen Inhalts als auch das Einbinden spezifizierter
Profile, Ressourcen und Vokabulare. Zudem werden anhand des Tutorials die Voraussetzungen für den Einsatz der von HL7 Austria betriebenen FHIR&reg; IG Infrastructure veranschaulicht. 

### Ordnerstruktur
- Für den Implementierungsleitfaden legen wir uns ein neues Verzeichnis `ig-ips-at` an. Entsprechendes Verzeichnis stellt das Wurzelverzeichnis des Implementierungsleitfadens dar. Der *IG Publisher* setzt für 
das Erzeugen eines FHIR&reg; Implementierungsleitfadens eine bestimmte Ordnerstruktur voraus. Glücklicherweise, berücksichtigen die Entwickler von Sushi bei der Erstellung eines Sushi-Projektes diese Voraussetzungen. Damit kann über eine Konsole mittels dem nachfolgenden Befehl ein solches Sushi-Projekt erzeugt werden, welches zeitgleich die notwendigen Voraussetzungen für eine nachgelagerte Nutzung des *IG Publisher* erlaubt. 

```bash
sushi init 
```

- Mit Ausführung obigen Kommandos wird ein Sushi Projekt erstellt, dabei werden über die Konsole wesentliche Parameter des zu erstellenden *Implementation Guide* abgefragt. Es sind grundsätzlich beliebige Parameterwerte erlaubt, für das vorliegende Beispiel verwenden wir nachfolgende Angaben:

| Parameter  |  Eingabe  |
|---|---|
| Name |  ig-ips-at  |
| Id  |  ips-at.example  |
| Canonical  |  http://fhir.hl7.at/ips-at  |
| Status |  draft  |
| Version |  0.1.0  |
| Publisher Name  |  HL7 Austria  |
| Publisher Url |  http://hl7.at  |

- Nachdem die entsprechenden Eingaben getätigt wurden, erzeugt Sushi die benötigte Ordnerstruktur gemäß nachfolgender Auflistung.

```bash
/ig-ips-at
    ├── input                     # contains content (resources, profiles, valuesets, narratives) for the IG
    ├── input-cache               # contains the ig-publisher executable and fhir specifications
    ├── fsh-generated             # contains output generated from sushi build command
    ├── _genonce.[bat|sh]         # run script to generate IG
    ├── _gencontinous.[bat|sh]    # run script to generate an publish IG in FHIR&reg; Registry
    ├── _updatePublisher.[bat|sh] # updates publisher.jar and definitions
    ├── ig.ini                    # control file for ig generation
    ├── sushi-config.yaml         # configuration for suhsi and IG properties
```

<span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Der *IG Publisher* kann auch gänzlich ohne den Einsatz von FHIR&reg; Shorthand und dem damit verbundenen Sushi Werkzeug verwendet werden. In solch einem Szenario erfolgen die notwendigen Profilierungen von FHIR&reg; direkt unter Definition entsprechender FHIR&reg; Ressourcen (bspw. `StructureDefinition`) via XML- oder JSON-Repräsentation. 

- Der *IG Publisher* wird in Folge in entsprechendem Verzeichnis aufgerufen. Sofern der *IG Publisher* noch nicht 
ausgeführt wurde, ist das Skript `_updatePublisher.[bat|sh]` im Vorhinhein auszuführen. Sodann kann über das Skript `_genonce.[bat|sh]` der Implementierungsleitfaden erstellt werden.

<span style="border-radius: 3px;background-color:red; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">!</span> Achtung, *IG Publisher* erfordert die Installation von Java, NPM und Jekyll, sofern eine der angeführten Abhängigkeiten nicht erfüllt ist, kann kein Implementierungsleitfaden erzeugt werden. Darüber hinaus erfordert die Erstellung eines Implementierungsleitfadens eine aktive Internetverbindung.

<span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Alternativ zur bereitgestellten Verzeichnisstruktur kann als Grundlage
für die Erstellung das offizielle Beispiel Projekt unter https://github.com/FHIR/sample-ig verwendet werden.

- Die im Verzeichis `input/fsh` abgelegt Shorthand-Datei `patient.fsh` umfasst ein Beispiel für ein Profil auf die Ressource `Patient`. Dieses als fsh-File bezeichnete Profil wird von Sushi bei der Übersetzung in eine FHIR&reg; Ressource in JSON-Repräsentation übersetzt. Die resultierenden JSON FHIR&reg; Ressourcen finden sich im `fsh-generated` Verzeichnis. 
- Der *IG Publisher* verarbeitet entsprechende Ressourcen im `fsh-generated` Ordner und erstellt daraus in Folge den fertigen Implementation Guide als HTML-Webseite. 
- Sobald die Erstellung des Implementierungsleitfaden abgeschlossen ist, kann der Leitfaden über die Datei `index.html`
im Verzeichnis `output` geöffnet werden. Das Beispeil-Profil für die Ressource `Patient` findet sich unter der Addresse `/StructureDefinition-MyPatient.html`.

### Darstellung/Layout und Narrative Inhalte Anpassen
Der *IG Publisher* erlaubt weitreichende Anpassungen und Konfigurationen was das Aussehen und die Darstellung des erzeugten Implementierungsleitfadens betrifft. Diese Anpassungen beruhen vielfach auf der Erstellung von *Markdown* oder *HTML-Dateien* in Verbindung mit Jekyll-Templates. Details dazu sind bitte der Dokumentation des *IG Publisher* zu entnehmen.

- Als einfaches Beispiel, starten wir mit der Anpassung der Menüeinträge. Zentraler Einstiegspunkt für alle Konfiguration stellt primär die Datei `sushi-config.yaml` dar. Diese erlaubt es einfache Konfigurationen festzulegen, Sushi parametriert in Fole den *IG Publisher* um diese Konfiguration weiterzugeben. So können wir bspw. ein Link auf ein Inhaltsverzeichnis als Teil des Menüs ergänzen.

```yaml
menu:
  Home: index.html
  Table of Contents: toc.html
  Resources: artifacts.html
```
- Sämtliche Abstraktionen der Konfigurationsparameter, die von Suhsi für den *IG Publisher* bereitgestellt werden, können auch überschrieben werden. Angenommen, wir möchten größeren Einfluss auf die Menüstruktur unseres Implementierungsleitfadens nehmen. Dazu kommentieren wir in der `sushi-config.yaml` folgende Zeilen durch voranstellen eines `#` aus. 

```yaml
menu:
  Home: index.html
  Table of Contents: toc.html
  Resources: artifacts.html
```
- Nun wird im Verzeichnis `inputs` ein Verzeichnis `includes` erstellt, wo eine `menu.xml`-Datei abgelegt wird. 

```xml
<ul xmlns="http://www.w3.org/1999/xhtml" class="nav navbar-nav">
  <li><a href="index.html">Introduction</a></li>  
  <li><a href="artifacts.html">Resources</a></li> 
  <li><a href="toc.html">Table of Contents</a></li>
  <li class="dropdown">
    <a data-toggle="dropdown" href="#" class="dropdown-toggle">Other Resources<b class="caret"> </b></a>
    <ul class="dropdown-menu">
      <li><a target="_blank" href="{{site.data.fhir.path}}index.html">FHIR Spec <img src="external.png" style="text-align: baseline"/></a></li>
    </ul>
  </li>
</ul>
```
<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_01/menu.xml](./templates/ex_01/menu.xml)


<span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Bei der Datei handelt es sich um eine `xhtml`-Datei, d.h. es kann im wesentlichen HTML-Content in das Menü eingefügt werden. Die Erstellung von `xhtml`-Inhalten und dem Menü gestaltet sich derzeit noch etwas komplex, seitens des *IG Publisher* wird in Zukunft eine alternative Möglichkeit bereitgestellt werden.

- Die Datei `menu.xml` legt die grundlegende Menüstruktur des gerenderten Implementierungsleitfadens fest. Anpassungen wirken sich bei der Erstellung direkt auf die Struktur und den Inhalt des Menü im gerenderten Implementierungsleitfaden aus.

- Als nächstes wechseln wir in das Verzeichnis `input/pagecontent`, dort wird findet sich eine Datei `index.md`, die den Inhalt der Landing-Page des Implementierungsleitfadens darstellt. Der Inhalt der Datei kann unter Einsatz von Markdown beliebig gestaltet werden. Sinngemäß enthält die Landing-Page eine grundlegende Beschreibung des Implementierungsleitfadens. Für das vorliegende Beispiel haben wir uns der Einfachheit-halber von der Beschreibung des IPS bedient.

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_02/index.md](./templates/ex_02/index.md)

- In Folge soll das bestehende Template durch eine eigenes ersetzt werden. HL7 Austria hat hierfür ein eigenes Template erstellt, das auch im offziellen Template-Repository der HL7-International verfügbar gemacht wurde. 
- Basis für die Konfiguration des *IG Publisher* stellt die Datei `ig.ini` dar. Sie enthält allgemeine Konfigurationsparameter wie Versionsnummer und Erstellungsjahr. Darüber hinaus wird in der `ig.ini` Datei festgelegt, welches Template als Grundlage für die Erstellung des Leitfadens eingesetzt werden soll. Eine Übersicht aller verfügbaren Parameter findet sich in https://confluence.hl7.org/display/FHIR/Implementation+Guide+Parameters.
- Das Template wird über den Parameter `template` definiert. Unter Angabe des folgenden Parameters kann das offizielle HL7 Austria Template verwendet werden.

```ini
[IG]
ig = fsh-generated/resources/ImplementationGuide-eMedication-at.example.json
template =  hl7.at.fhir.template#current
```
<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_03/igi.ini](./templates/ex_03/ig.ini)

<span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Sofern `_genonce.[bat|sh]` noch nie ausgeführt wurde, sollte vorher `_updatePublisher.[.bat|.sh]` ausgeführt werden. Dieses lädt die aktuelle Version des *IG Publisher* sowie die benötigten Definition in das Verzeichnis `input-cache`.

- Schließlich kann die Generierung über das Skript `_genonce.[bat|sh]` angestoßen werden. Nach erfolgreicher Ausführung befindet sich im generierten Verzeichnis `output` der gerenderte Leitfaden. Über die Datei `index.html` kann dieser in einem Webbrowser angezeigt werden.

<span style="border-radius: 3px;background-color:green; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&check;</span> Ein minimaler Implementierungsleitfaden wurde erstellt, die Struktur, narrativen Teile sowie die erstellte Ressource werden im gerenderten Leitfaden dargestellt.  

### Abhängigkeiten zwischen Implementierungsleitfäden
- Ein Implementierungsleitfaden kann auf Basis eines bestehenden Implementierungsleitfadens aufgebaut werden. Dazu kann in der Datei `sushi-config.yaml` eine Abhängigkeit auf einen anderen Leitfaden ergänzt werden.

<span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Wesentlich, damit ein abhängiger Leitfaden verarbeitet werden kann ist, dass dieser in der offziellen FHIR IG Registry enthalten ist (siehe http://fhir.org/guides/registry/).

- Im vorliegenden Fall soll der vorliegende IG auf dem International Patient Summary aufbauen. Dazu wird die Datei `sushi-config.yaml` wie folgt adaptiert.

```yaml
dependencies:
  hl7.fhir.uv.ips: current
  #hl7.fhir.uv.ips: 1.1.0
```
<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_04/sushi-config.yaml](./templates/ex_04/sushi-config.yaml)

- Die Versionsangabe nach dem Doppelpunkt kann entweder `current` also die aktuelle Version enthalten oder aber eine spezifische Version bspw. `hl7.fhir.uv.ips:1.1.0`.
- Nachdem der Leitfaden über den Befehl `_genonce.sh|bat` neu erstellt wird, können über den QA-Report alle abhängigen Pakete dargestellt werden. So auch bspw. den FHIR-Core Extension Pack.
- Ab diesem Zeitpunkt können nun Ressourcen auf der Grundlage bestehender Leitfäden erstellt werden. Nehmen wir als Beispiel wiederum die Ressource `Patient`, i.e. das von uns erstellte Patientenprofil in der Datei `patient.fsh` und ändern diese wie folgt ab, um festzulegen, dass unsere Patientenressource auf dem IPS Patienten aufbaut. 

```yaml{highlight=2}
Profile: MyPatient
Parent: PatientUvIps
Description: "An example profile of the Patient resource."
* name 1..* MS

Instance: PatientExample
InstanceOf: MyPatient
Description: "An example of a patient with a license to krill."
* name
  * given[0] = "James"
  * family = "Pond"
```

<span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Der Name der `Parent`-Ressource kann im IPS Leitfaden nachgelesen werden (siehe http://hl7.org/fhir/uv/ips/StructureDefinition-Patient-uv-ips.html). 


- Der IG Publisher wird neuerlich ausgeführt und schlägt fehl. Hintergrund ist, dass der IPS Patient einige Festlegungen hinsichtlich der erforderlichen Attribute eines Patienten festlegt. Das Profil unseres einfachen Patienten aber schlichtweg diese Bedingungen nicht erfüllt. 
- Um das Problem zu lösen, wird unsere Structure Definition für den Patienten wie folgt abgeändert. 

```yaml
Profile: MyPatient
Parent: PatientUvIps
Description: "An example profile of the Patient resource."
* name 1..* MS
* birthdate 1..1

Instance: PatientExample
InstanceOf: MyPatient
Description: "An example of a patient with a license to krill."
* name
  * given[0] = "James"
  * family = "Pond"
* birthDate = "1905-08-23"
```

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_05/patient.fsh](./templates/ex_05/patient.fsh)

- Pakete werden in eine lokale Package-Registry geladen. Diese ist unter `~/.fhir` zu finden. 
- Voraussetzung damit ein Paket aufgelöst werden kann, es muss sich in der offziellen FHIR Registry unter registry.fhir.org befinden. 

- Sofern sich ein Paket nicht in dieser Registry befindet, kann es manuell ergänzt werden. Dazu kann die Datei `package.tgz` eines Implementierungsleitfadens geladen (bspw. https://fhir.hl7.at/r4-core-ballot_2021_01/index.html) werden und der Inhalt entsprechend der folgenden Ordnerstruktur entpackt werden. 

```bash
/.fhir/packages
    ├── HL7ATCoreProfiles#4.0.1
      ├── package
        ├── // Inhalt der package.tgz Datei hier entpacken
      ├── usage.ini
```

- Nun kann ein weiterer IG als Abhängigkeit ergänzt werden, dies erfolgt wie bisher über die `sushi-config.yaml`

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_06/sushi-config.yaml](./templates/ex_06/sushi-config.yaml)


<span style="border-radius: 3px;background-color:green; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&check;</span> Der Implementierungsleitfaden wurde um Abhängigkeiten zu anderen Leitfäden ergänzt. 

### Ergänzen von Profilen

- Nachdem der narrative Inhalt erstellt wurde kümmern wir uns um die Erstellung jener Inhalte, die auf Grundlage von definierten Profilen automatisch erstellt werden.
- Ein Profil besteht bereits, im Verzeichnis `profiles` befindet sich eine `StructureDefinition` für eine `Patient`-Ressource.
- Da es sich beim vorliegenden Implementierungsleitfaden um ein IG auf Basis des International Patient Summary handelt, erstellen wir ein Profil für die Ressource `Medication`, sodass wir die Pharamzentralnummer als `Identifier` ergänzen können.

- Als nächsten Schritt ergänzen wir die Pharmazentralnummer in das Profil für `Medication`. Für die Festlegung, dass eine Medikation in Österreich über eine Pharmazentralnummer verfügen muss, bedienen wir uns eines Profils auf die FHIR&reg; Ressource `Medication`. Nachfolgend dargestellt, findet sich das entsprechende Profil in Form von FHIR&reg; Shorthand Syntax. Konkret wird ein Slice auf das Element `Code.Coding` erstellt. Als Diskriminator (identifizierende Eigenschaft) wird das 
Element `System` und deren Fixwert `urn:oid:1.2.40.0.34.4.16` festgelegt. Gemäß Slice-Definition ist der Slice offen, die Pharmazentralnummer darf maximal einmal vorkommen.

```yaml
Profile: AustrianMedication
Parent: Medication-uv-ips
Id: austrian-medication
Title: "Austrian Medication"
Description: "FHIR Base Profile for Medication Data in Austria"
* ^extension.url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-category"
* ^extension.valueString = "Base.Individuals"
* ^version = "0.1.0"
* ^status = #active
* . ^short = "Medication"
* . ^definition = "Medication"
* . ^alias = "Medication"
* . ^base.path = "Medication"
* . ^base.min = 0
* . ^base.max = "*"
* code.coding ^slicing.discriminator.type = #value
* code.coding ^slicing.discriminator.path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains pharmazentral 0..1
* code.coding[pharmazentral] ^fixedCoding.system = "urn:oid:1.2.40.0.34.4.16"
* code.coding[pharmazentral] ^fixedCoding.display = "Pharmazentralnummer"
```
<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_07/austrian-medication.fsh](./templates/ex_07/austrian-medication.fsh)

- Das Profil wird unter `input/fsh/austrian-medication.fsh` gespeichert.

<span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Auch wenn die Verwendung von `urn:oid` grundsätzlich in FHIR&reg; nicht verboten ist, wird empfohlen, wo möglich "Menschenlesbare"-URI anzugeben.

- In Folge kann der Implementierungsleitfaden neu erstellt werden. Die bestehende Beispiel FHIR Ressource `Patient` kann gelöscht werden. Das Skript `_genonce.sh|bat` wird erneut angestoßen und wir betrachten das Resultat im Browser

- Anhand eines weiteren Profiles, demonstrieren wir, wie die Beziehung zwischen 2 Ressourcen anhand eines `Reference`-Elements auf die Verwendung eines Profils eingeschränkt werden kann.
- Das vorbereitete Profil `austrian-medication-request.request` wird in das `profiles`-Verzeichnis kopiert. Da wir in Folge sicherstellen möchten, dass ein `Austrian-Medication-Request` auf einen `AustrianPatient` verweist, wird unser Patienten Profil wie folgt adaptiert.

```yaml
Alias: $austrian-patient = at-core-patient
Profile: AustrianIPSPatient
Parent: PatientUvIps
Id: at-core-ips-patient
Title:          "HL7® AT Core Patient Profile for IPS"
Description:    "HL7® Austria FHIR® Core Profile for patient data in Austria within the context of the IPS.
The HL7® AT Core Patient is based upon the core FHIR® Patient Resource and designed to meet the applicable patient demographic data elements in Austria. It identifies which core elements, extensions, vocabularies and value sets SHALL be present in the resource when using this profile. Note, this extension represents the common structure of Patient information within Austrian information systems."
* name 1..* MS
* link.other only Reference($austrian-patient)
```

- Nun wird die Ressource Medication Request in das `fsh/input` Verzeichnis kopiert. 

```bash
/ig-ips-at
    ├── input                  
      ├── fsh
        ├── austrian-address-representation.fsh
        ├── austrian-medication.fsh
        ├── austrian-medication-request.fsh
        ├── austrian-patient.fsh
        ├── patient-religion.fsh
```


<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_08/](./templates/ex_08/)

- Um die Elemente `medication` und `subject` auf die Verwendung unserer definierten Profile einzuschränken, wird nachfolgender Inhalt in das Profil ergänzt.

```yaml
Alias: $austrian-medication = http://fhir.hl7.at/ips-at/StructureDefinition/austrian-medication
Alias: $austrian-ips-patient = AustrianIPSPatient
Alias: $ips-patient = http://hl7.org/fhir/uv/ips/StructureDefinition/Patient-uv-ips

Profile: AustrianMedicationRequest
Parent: MedicationRequest-uv-ips
Id: austrian-medication-request
Title: "Austria Medication Request"
Description: "FHIR Base Profile for Medication Data in Austria"
* ^extension.url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-category"
* ^extension.valueString = "Base.Individuals"
* ^version = "0.1.0"
* ^status = #active
* . ^short = "MedicationRequest"
* . ^definition = "MedicationRequest"
* . ^alias = "MedicationRequest"
* . ^base.path = "MedicationRequest"
* . ^base.min = 0
* . ^base.max = "*"
* medicationReference only Reference($austrian-medication)
* medicationReference ^sliceName = "medicationReference"
* subject only Reference($austrian-ips-patient)
```

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_08/](./templates/ex_08/)

- Um für generierte Inhalte auf der Grundlage von Ressourcen und Profilen auch narrative Beschreibungen zu ergänzen, kann je eine *Introduction* sowie eine Gliederungsebene *Notes* zu einer Ressource ergänzt werden. Dies erfolgt durch hinzufügen 2er Dateien, deren Dateiname die betroffene Ressource enthält.

> Bsp.: für die Ressource `austrian-medication` werden je eine Datei `StructureDefinition-austrian-medication-intro.md` respektive `StructureDefinition-austrian-medication-intro.md` ergänzt.

- Da es sich bei diesen Dateien um Markdown-Inhalte handelt, werden diese im Verzeichnis `input/pagecontent` abgelegt. 

<span style="border-radius: 3px;background-color:red; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">!</span> Vorsicht ist bei der Benennung geboten, der *IG Publisher* setzt hier sehr stark auf Konventionen, sofern diese nicht erfüllt sind, werden entsprechende Dateien ignoriert oder es kommt gar zu einer Fehlermeldung. 

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_09/](./templates/ex_09/)


### Ergänzen von ValueSets

- Neben Extensions und Profilen ist es auch möglich Ressourcen für Terminologien in den Implementierungsleitfaden zu integrieren.
Entsprechende Ressourcen können im Verzeichnis `input/vocabulary` eingefügt werden.
- Im folgenden Beispiel wollen wir eine neue FHIR&reg; `ValueSet`-Ressource für das Valueset *ELGA-Medikation-Frequenz* erstellen. Als zugrundeliegendes Codesystem wird im Falle des ELGA-Valusets UCUM (unitofmeasures.org) verwendet &rarr; https://termgit.elga.gv.at/ValueSet-elga-medikationfrequenz
- Wir beginnen damit eine neue Datei `ValueSet-elga-medication-frequency.json` im Verzeichnis `input/vocabulary` zu erstellen. 
- Gemäß der Definition des Valuesets im Terminologieserver werden entsprechende Codes übernommen. Als Codesystem fungiert unitofmeasure.org - https://www.hl7.org/fhir/valueset-ucum-units.html

```yaml
Alias: $unitsofmeasure = http://unitsofmeasure.org

ValueSet: ELGAMedicationFrequency
Id: elga-medication-frequency
Title: "ELGA Medication Frequency"
Description: "ELGA ValueSet for frequency."
* ^meta.lastUpdated = "2019-11-01T09:29:23.356+11:00"
* ^url = "https://termgit.elga.gv.at/ValueSet-elga-medikationfrequenz"
* ^version = "0.1.0"
* ^status = #active
* ^experimental = false
* ^date = "2019-11-01T09:29:23+11:00"
* ^publisher = "ELGA GmbH"
* ^contact.telecom.system = #url
* ^contact.telecom.value = "http://elga.gv.at"
* ^immutable = true
* $unitsofmeasure#d "Day"
* $unitsofmeasure#mo "Month"
* $unitsofmeasure#wk "Week"
```

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_08/elga-medication-frequency.fsh](./templates/ex_08/elga-medication-frequency.fsh)


- Nach neuerlichem Ausführen des Skripts `_genonce.sh|bat` wird die neue Version des IG in das `output`-Verzeichnis gerendert. Betrachtet man das Resultat, so zeigt sich, dass der *IG Publisher* automatisch eine ValuSet-Expansion vornimmt. D.h. die zu inkludierenden Codes des zugrundeliegende Codesystem werden (sofern auflösbar) in das Valueset integriert.

<span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Wesentliche Grundlage für eine gültige Expansion ist, dass das zugrundeliegende Codesystem auflösbar, als FHIR&reg;-Ressource, sein muss (vgl. FHIR&reg; Terminologieserver tx.fhir.org).

```yaml
Alias: $v3-TimingEvent = http://terminology.hl7.org/CodeSystem/v3-TimingEvent

ValueSet: ELGATimingEventsDrugAdministration
Id: elga-timing-events-drug-administration
Title: "ELGA Timing Events Drug Administration"
Description: "ELGA ValueSet for timing of drug administration."
* ^meta.lastUpdated = "2019-11-01T09:29:23.356+11:00"
* ^url = "https://termgit.elga.gv.at/ValueSet-elga-einnahmezeitpunkte"
* ^version = "0.1.0"
* ^status = #active
* ^experimental = false
* ^date = "2019-11-01T09:29:23+11:00"
* ^publisher = "ELGA GmbH"
* ^contact.telecom.system = #url
* ^contact.telecom.value = "http://elga.gv.at"
* ^immutable = true
* $v3-TimingEvent#ACD "ACD"
* $v3-TimingEvent#ACM "ACM"
* $v3-TimingEvent#ACV "ACV"
* $v3-TimingEvent#HS "HS"
```
<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_09/elga-timing-events-drug-administration.fsh](./templates/ex_09/elga-timing-events-drug-administration.fsh)

- Schließlich muss wieder die Erstellung des IG angestoßen werden, es wird also wiederum das Skript `_genonce.sh|bat` ausgeführt und das Resultat im Browser angezeigt.

- Um auch die Möglichkeit der Angabe eines NULL-Flavor bei ValuSet zu haben, kann auf das entsprechende V3-Codesystem zurückgegriffen werden. Hierzu kann bspw. in einem
der definierten Valusets folgender möglicher Code ergänzt werden.
```yaml
Alias: $v3-TimingEvent = http://terminology.hl7.org/CodeSystem/v3-TimingEvent
Alias: $v3-NullFlavor = http://terminology.hl7.org/CodeSystem/v3-NullFlavor

ValueSet: ELGATimingEventsDrugAdministration
Id: elga-timing-events-drug-administration
Title: "ELGA Timing Events Drug Administration"
Description: "ELGA ValueSet for timing of drug administration."

...

* $v3-NullFlavor#UNK "Unknown"
```

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_10/elga-timing-events-drug-administration.fsh](./templates/ex_10/elga-timing-events-drug-administration.fsh)

- Ein abschließendes Ausführen des `_genonce.sh|bat` Skripts erstellt nun den finalen Implementierungsleitfaden.

### Ergänzen von Beispiel-Ressourcen

- Zu jedem Profil das im Rahmen des Implementierungsleitfadens definiert wird, können auch Beispiel-Ressourcen ergänzt werden. So kann bspw. eine konkrete Ausprägung des `Austrian Patient` als fsh-Datei in das Verzeichnis `fsh/input` kopiert werden. Auch hier ist wiederum auf die korrekte Benennung zu achten. 

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_11/austrian_patient-example01.fsh](./templates/ex_10/austrian_patient-example01.fsh)

<span style="border-radius: 3px;background-color:green; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&check;</span> Nachdem die Beispiel-Ressourcen hinzugefügt wurden, können diese im gerenderten Implementierungsleitfaden im Browser angezeigt werden

### Deployment in der HL7 Austria IG Infrastruktur
Für das Deployment eines FHIR&reg;-Implementierungsleitfadens in der HL7 Austria IG Infrastruktur gilt es sowohl organisatorische, als auch technische Voraussetzungen zu erfüllen. Was die organisatorischen Voraussetzungen betrifft, kann hier das Zuständige technische Kommittee unter tc-fhir@hl7.at 
weiterhelfen. Wesentliche technische Voraussetzung ist ein im GitHub Account von HL7 Austria verwaltetes GIT-Repository. Ein solches kann über das technische Kommittee beantragt werden. Nachfolgend werden unter der Voraussetzung entsprechenden Repositories die Anpassungen Ergänzungen am vorligen Implementierungsleitfaden demonstriert, um diesen quasi fit für ein Deployment in die HL7 Austria IG Infrastruktur zu machen.

- Die HL7 Austria Infrastruktur scant registrierte Implementierungsleitfäden auf das Vorhandensein einer speziellen Konfigurationsdatei. Diese Datei, ist im Verzeichnis '/input/landing-page' als `_index.yml` anzulegen.


```bash
/ig-eMedication-at
    ├── input                  
      ├── landing-page
        ├── index.yml
```

- Die Datei `index.yml` enthält sog. Projektkoordinaten, d.s. unter anderem Details zum Namen und der Version des entsprechenden Implementierungsleitfadens. Konkret gestaltet sich der Aufbau im Falle des vorliegenden Implementierungsleitfadens wie folgt:

```yaml
- name: HL7 IG Infrastructure Workshop
- version: 0.1.0
- description: Sample Implementation Guide for the annual HL7&reg; Austria meeting workshops.
- last_published: %%date%%
- branch: %%branch%%
- type: draft
```

- Nebst dem Namen, der Version und der Beschreibung des Implementierungsleitfaden werden Daten zum letzten Zeitpunkt der Veröffentlichung, der jeweilige Branch (Git-Branch) sowie den Typ des jeweiligen Repositories. Gültige Werte für letzters sind `draft|official|main`. Während `main` und `draft` von allen HL7 Mitgliedern verwendet werden können, ist die Verwendung von `official` nur Implementierungsleitfäden von HL7 Austria vorbehalten.
    - für `main` gilt: Diese werden unter fhir.hl7.at im Bereich *HL7 Austria Member IGs* angezeigt.
    - für `draft` gilt: Dieser werden unter fhir.hl7.at im Bereich *Working Drafts* angezeigt. 

- Nachdem die Datei ergänzt wurde, kann der Implementierungsleitfaden in das zur Verfügung gestellte Git-Repository gepushed werden. Als Teil der organistorischen Voraussetzungen, wird das entsprechende Repository mit einer GitHub-Action versehen, die beim Atkualisieren einzelner Branches, bspw. durch Commit und anschließendem Push angestoßen wird. 
- Diese Action prüft, ob alle technischen Voraussetzungen gegeben sind und erstellt ein IG Paket, das in das hl7austria.github.io Repository deployed wird. 
- Abschließend wird von entsprechendem Repository ein Deployment des Implementierungsleitfadens auf fhir.hl7.at vollzogen. Nach erfolgtem Deployment kann der Implementierungsleitfaden unter fhir.hl7.at angezeigt und ausgewählt werden.

<span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Dieser Ablauf wird für alle Branches im Quell-Repository durchgeführt. Sofern ein bestimmter Branch nicht deployed werden soll, so kann dies durch Entfernen der `_index.yml` Datei für diesen Branch erfolgen

### OpenAPI + Capabilities ergänzen
- In einem nächsten Schritt wird über die Erstellung eines `CapabilitiyStatement` festgelegt, wie die API und damit die Interaktion mit den im Leitfaden definierten Ressourcen erfolgt. 
- Das folgende `CapabilityStatement` definiert 2 Interaktionen auf die Ressource `MedicationRequest`

```yaml
Instance: HL7ATCoreIPSCapabilities
InstanceOf: CapabilityStatement
Title:          "HL7® AT Core IPS Capabilities"
Description:    "HL7® Austria FHIR® Core Capabilities for accessing Austrian Patient resource."
Usage: #definition
* name = "HL7® AT Core IPS Capabilities"
* rest.resource.type = #MedicationRequest
...
* rest.resource.interaction[0].code = #read
* rest.resource.readHistory = false
* rest.resource.updateCreate = false
* rest.resource.conditionalCreate = false
* rest.resource.conditionalRead = #full-support
* rest.resource.conditionalUpdate = false
* rest.resource.conditionalDelete = #not-supported

* rest.resource.searchParam[0].name = "subject"
* rest.resource.searchParam[=].type = #reference
```

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_15/austrian_medication_request_capabilities.fsh](./templates/ex_15/austrian_medication_request_capabilities.fsh)


- Beim Erstellen des Implementierungsleitfadens über den Befehl `_genonce.sh|bat` wird in Folge nebst dem `CapabiltityStatement` auch eine OpenAPI Datei erzeugt. Diese kann in Folge als Grundlage für die Generierung von Client / Server-Anwendungen fungieren.

 
