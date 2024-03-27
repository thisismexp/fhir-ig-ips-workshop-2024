---
presentation:
  slideNumber: true
---

<!-- .slide: data-background="#123456" class="overview-slide" -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides* mit dem IG Publisher
***
### Andreas Schuler & Oliver Krauss
#### *12.03.2024*
### *HL7 Austria Jahrestagung 2024*


<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Vorbedingungen
***
Im Rahmen des Workshops werden folgende Werkzeuge eingesetzt
- *IG Publisher* &ndash; https://github.com/HL7/fhir-ig-publisher
- *FHIR&reg; Shorthand.* &ndash; https://github.com/FHIR/sushi

Alle Unterlagen/Skripte/etc. finden sich unter 
### [https://github.com/HL7Austria/fhir-ig-ips-workshop](https://github.com/HL7Austria/fhir-ig-ips-workshop)


<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Vorbedingungen
***
### Frameworks
- **Java:** Für das Ausführen des *IG Publisher* und damit das Erstellen eines Implementierungsleitfadens ist eine Java-Installation am Rechner erforderlich.
- **Jekyll:** Das Jekyll-Framework wird von *IG Publisher* verwendet um die einzelnen Teile des Implementierungsleitfadens in eine Webseite und damit den gerenderten Implementierungsleitfaden zu überführen.
- **Node Package Manager:** wird für die Installation von *Sushi* benötigt.
- **Sushi:** Sushi ist streng genommen ein Transpiler, der auf Grundlage einer domänenspezifischen Sprache (FHIR&reg; Shorthand) eine effiziente Möglichkeit für das Erstellen von FHIR&reg; Implementation Guides darstellt.

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Vorbedingungen
***
### Werkzeuge
Für das Tutorial werden überdies folgende Tools zur Erstellung des  Implementierungsleitfadens verwendet:
- Visual Studio Code &ndash; https://code.visualstudio.com
- Visual Studio Code FHIR&reg; Tools
- Visual Studio Code XML Language Server
- Visual Studio Code FHIR&reg; Shorthand

> <span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Grundsätzlich kann ein beliebiger Editor verwendet werden. Visual Studio Code bietet allerdings mit entsprechenden Plugins hilfreiche Werkzeuge, die bei der Erstellung von Implementierungsleitfäden unterstützen können.

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
Als Grundlage für das Tutorial fungiert der Implementierungsleitfaden für das International Patient Summary (IPS).
- Erstellung eines FHIR&reg;-Implementierungsleitfadens
- Ausgehend von Minimalanforderungen eines FHIR&reg;-Implementierungsleitfadens schrittweises erstellen von 
  - narrativen Inhalten 
  - und einbinden spezifizierter Profile, Ressourcen und Vokabular. 
- Dependencies und Dependency Management
- Definition von APIs auf Basis von `CapabilityStatement`
- Voraussetzungen für Einsatz der HL7 Austria FHIR&reg; IG Infrastructure 

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Projektstruktur
Der *IG Publisher* setzt für das Erzeugen eines FHIR&reg; Implementierungsleitfadens eine bestimmte Ordnerstruktur voraus

```bash
sushi init .
```

- Intialisierung einer gültigen Struktur über *Sushi*

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Projektstruktur
Initialierung eines *Sushi*-Projektes, über Konsole werde wesentliche Parameter des zu erstellenden *Implementation Guide* abgefragt. 

| Parameter  |  Eingabe  |
|---|---|
| Name |  ig-ips-at  |
| Id  |  ips-at.example  |
| Canonical  |  http://fhir.hl7.at/ips-at  |
| Status |  draft  |
| Version |  0.1.0  |
| Publisher Name  |  HL7 Austria  |
| Publisher Url |  http://hl7.at  |


<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Projektstruktur
Ordnerstruktur nach Intialisierung eines *Sushi*-Projektes

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

<span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Der *IG Publisher* kann auch gänzlich ohne den Einsatz von FHIR&reg; Shorthand und dem damit verbundenen _Sushi_-Werkzeug verwendet werden. In solch einem Szenario erfolgen die notwendigen Profilierungen von FHIR&reg; direkt unter Definition entsprechender FHIR&reg; Ressourcen (bspw. `StructureDefinition`) via XML- oder JSON-Repräsentation. 

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Projektstruktur - IG bauen und paketieren
Das Skript `_updatePublisher.[bat|sh]` im Vorhinhein auszuführen. Sodann kann über das Skript `_genonce.[bat|sh]` der Implementierungsleitfaden erstellt werden.


<span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Alternativ zur bereitgestellten Verzeichnisstruktur kann als Grundlage für die Erstellung das offizielle Beispiel Projekt unter https://github.com/FHIR/sample-ig verwendet werden.


<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Darstellung/Layout und Narrative Inhalte Anpassen
*IG Publisher* erlaubt weitreichende Anpassungen und Konfigurationen was das Aussehen und die Darstellung des erzeugten Implementierungsleitfadens betrifft

Anpassungen beruhen vielfach auf der Erstellung von *Markdown* oder *HTML-Dateien* in Verbindung mit _Jekyll_-Templates. Details dazu sind bitte der Dokumentation des *IG Publisher* zu entnehmen

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Darstellung/Layout und Narrative Inhalte Anpassen
- Zentraler Einstiegspunkt für Konfigurationen stellt Datei `sushi-config.yaml`

```yaml
menu:
  Home: index.html
  Table of Contents: toc.html
  Resources: artifacts.html
```

- Sushi parametriert in Folge den *IG Publisher*. So können wir bspw. ein Link auf ein Inhaltsverzeichnis als Teil des Menüs ergänzen.

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Darstellung/Layout und Narrative Inhalte Anpassen
Umfangreichere Umgestaltung durch Bereitstellung eigener _Jekyll_-Templates
- Im Verzeichnis `inputs` ein Verzeichnis `includes` erstellen sowie eine `menu.xml`-Datei erzeugen 

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

<span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Bei der Datei handelt es sich um eine `xhtml`-Datei, d.h. es kann im wesentlichen HTML-Content in das Menü eingefügt werden.


<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Darstellung/Layout und Narrative Inhalte Anpassen
Wechseln wir in das Verzeichnis `input/pagecontent`, dort findet sich eine Datei `index.md`, die den Inhalt der Landing-Page des Implementierungsleitfadens darstellt. 

Der Inhalt der Datei kann unter Einsatz von Markdown beliebig gestaltet werden. 

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_02/index.md](./templates/ex_02/index.md)


<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Darstellung/Layout und Narrative Inhalte Anpassen
In Folge soll das bestehende Template durch eine eigenes ersetzt werden 
- HL7 Austria hat hierfür ein eigenes Template erstellt, das auch im offziellen Template-Repository der HL7-International verfügbar gemacht wurde
- Basis für die Konfiguration des *IG Publisher* stellt die Datei `ig.ini` dar
  Eine Übersicht aller verfügbaren Parameter findet sich in https://confluence.hl7.org/display/FHIR/Implementation+Guide+Parameters
- Das Template wird über den Parameter `template` festgelegt

```ini
[IG]
ig = fsh-generated/resources/ImplementationGuide-ips-at.example.json
template =  hl7.at.fhir.template#current
```
<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_03/igi.ini](./templates/ex_03/ig.ini)

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Abhängigkeiten zwischen Implementierungsleitfäden
Ein Implementierungsleitfaden kann auf Basis eines bestehenden Implementierungsleitfadens aufgebaut werden.
- Abhängigkeiten werden in einer zentralen FHIR-Registry verwaltet &rarr; siehe http://fhir.org/guides/registry/
- Festlegung in der Datei `sushi-config.yaml`
- FHIR-Packages werden in lokaler Registry gecached &rarr; typischerweise im Verzeichnis `~/.fhir`

```yaml
dependencies:
  hl7.fhir.uv.ips: current
```
<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_04/sushi-config.yaml](./templates/ex_04/sushi-config.yaml)

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Abhängigkeiten zwischen Implementierungsleitfäden
Sobald die Abhängigkeiten definiert sind, können Profile aus den abhängigen Leitfäden verwendet werden. 
### Beispiel 
- das von Sushi erstellte Patienten-Profil in der Datei `patient.fsh` setzt auf das in IPS definierte `PatientUvIps` Profil auf.

```yaml
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

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_05/patient.fsh](./templates/ex_05/patient.fsh)


<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Abhängigkeiten zwischen Implementierungsleitfäden
Sobald die Abhängigkeiten definiert sind, können Profile aus den abhängigen Leitfäden verwendet werden. 
### Beispiel 
- IPS definiertes Patient Profil legt Kardinalität `birthDate` mit `1..1` fest. 
- Das Element `birthDate` muss ergänzt werden, damit die Validierung erfolgreich durchgeführt werden kann. 

```yaml
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
* birthDate = "1905-08-23"
```

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_05/ppatient.fsh](./templates/ex_05/patient.fsh)

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Abhängigkeiten zwischen Implementierungsleitfäden
- Pakete werden in eine lokale Package-Registry geladen `~/.fhir`.
- Sofern sich ein Paket nicht in dieser Registry befindet, kann es manuell ergänzt werden. Dazu kann die Datei `package.tgz` eines Implementierungsleitfadens geladen werden und der Inhalt entsprechend der folgenden Ordnerstruktur entpackt werden. 

```bash
/.fhir/packages
    ├── HL7ATCoreProfiles#4.0.1
      ├── package
        ├── // Inhalt der package.tgz Datei hier entpacken
      ├── usage.ini
```

- Nun kann ein weiterer IG als Abhängigkeit ergänzt werden, dies erfolgt wie bisher über die `sushi-config.yaml`

```yaml
dependencies:
  hl7.fhir.uv.ips: current
  HL7ATCoreProfiles: 4.1.0
```

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_06/sushi-config.yaml](./templates/ex_06/sushi-config.yaml)

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiel International Patient Summary (IPS)
***
### Ergänzen von Profilen - Medication Structure Definition
Für vorliegenden Implementierungsleitfaden auf Basis von IPS wird in Anlehnung an die ELGA e-Medikation die Ressource Medication profiliert,
-  vorrangig ein Profil für die Ressource `Medication`, sodass Pharamzentralnummer als `Identifier` ergänzt werden kann

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Ergänzen von Profilen - Medication Structure Definition

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

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Ergänzen von Profilen - Profile auf Reference
- In Folge kann der Implementierungsleitfaden neu erstellt werden. Die bestehende Beispiel FHIR Ressource `Patient` kann gelöscht werden. Das Skript `_genonce.sh|bat` wird erneut angestoßen und wir betrachten das Resultat im Browser

- Anhand eines weiteren Profiles, demonstrieren wir, wie die Beziehung zwischen 2 Ressourcen anhand eines `Reference`-Elements auf die Verwendung eines Profils eingeschränkt werden kann

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Ergänzen von Profilen - Profile auf Reference
- ein `Austrian-Medication-Request` soll nur auf einen `AustrianPatient` verweisen können
- Das vorbereitete Profil `austrian-medication-request.request` wird in das `input/fsh`-Verzeichnis kopiert. 

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


<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_05/](./templates/ex_05/)

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Ergänzen von Profilen - Profile auf Reference
- Um die Elemente `medication` und `subject` auf die Verwendung unserer definierten Profile einzuschränken, wird nachfolgender Inhalt in das Profil ergänzt

```yaml
Alias: $austrian-medication = http://fhir.hl7.at/ips-at/StructureDefinition/austrian-medication
Alias: $austrian-ips-patient = AustrianIPSPatient
Alias: $ips-patient = http://hl7.org/fhir/uv/ips/StructureDefinition/Patient-uv-ips

Profile: AustrianMedicationRequest
Parent: MedicationRequest-uv-ips
Id: austrian-medication-request
Title: "Austria Medication Request"

...

* medicationReference only Reference($austrian-medication)
* medicationReference ^sliceName = "medicationReference"
* subject only Reference($austrian-ips-patient)
```
<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_08/](./templates/ex_08/)

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Ergänzen von Profilen - Profile auf Reference
- Wir ergänzen ein neues Profil für den AT IPS Patienten, der eine spezielle Extension verwendet, damit `1..*` zusätzliche Profile definiert werden können sog. &rarr; *Imposed Profiles*
- !! include hl7.fhir.uv.extensions: 5.1.0 dependency for this extension to be usable

```yaml
Alias: $austrian-patient = http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-patient
Alias: $impose-profile = http://hl7.org/fhir/StructureDefinition/structuredefinition-imposeProfile

Profile: AustrianIPSPatient
Parent: PatientUvIps
Id: at-core-ips-patient
Title: "HL7® AT Core Patient Profile for IPS"
* name 1..* MS
* ^extension[$impose-profile].valueCanonical = Canonical($austrian-patient)
```

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_08/](./templates/ex_08/)


<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Ergänzen von Profilen

- Um für generierte Inhalte auf der Grundlage von Ressourcen und Profilen auch narrative Beschreibungen zu ergänzen, kann je eine *Introduction* sowie eine Gliederungsebene *Notes* zu einer Ressource ergänzt werden. Dies erfolgt durch hinzufügen 2er Dateien, deren Dateiname die betroffene Ressource enthält.

- Für die Ressource `austrian-medication` werden je eine Datei 
  - `StructureDefinition-austrian-medication-intro.md` respektive 
  - `StructureDefinition-austrian-medication-intro.md` ergänzt

- Da es sich bei diesen Dateien um Markdown-Inhalte handelt, werden diese im Verzeichnis `input/pagecontent` abgelegt. 

<span style="border-radius: 3px;background-color:red; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">!</span> Vorsicht ist bei der Benennung geboten, der *IG Publisher* setzt hier sehr stark auf Konventionen, sofern diese nicht erfüllt sind, werden entsprechende Dateien ignoriert oder es kommt gar zu einer Fehlermeldung. 

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_09/](./templates/ex_09/)

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Ergänzen von Capabiltity Statements
- Über ein `CapabilityStatement` wird festgelegt, welche API-Interaktionen und Suchparameter für die im Leitfaden definierten Ressourcen erlaubt sind. 

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

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_15/austrian-ips-capabilities.fsh](./templates/ex_15/austrian-ips-capabilities.fsh)


<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Ergänzen von Value Sets

- Neben Extensions und Profilen auch Ressourcen für Terminologien festlegbar
  - Entsprechende Ressourcen können im Verzeichnis `input/vocabulary` eingefügt werden

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Ergänzen von Value Sets - ELGAMedicationFrequency
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

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Ergänzen von _Value Sets_
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

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Ergänzen von _Value Sets_
- Um auch die Möglichkeit der Angabe eines NULL-Flavor bei ValuSet zu haben, kann auf das entsprechende V3-Codesystem zurückgegriffen werden.
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

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Ergänzen von Beispiel-Ressourcen

- Zu jedem Profil das im Rahmen des Implementierungsleitfadens definiert wird, können auch Beispiel-Ressourcen ergänzt werden. So kann bspw. eine konkrete Ausprägung des `Austrian Patient` als fsh-Datei in das Verzeichnis `fsh/input` kopiert werden. Auch hier ist wiederum auf die korrekte Benennung zu achten. 

<span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">&#9999;</span> siehe Vorlage unter [templates/ex_11/austrian_patient-example01.fsh](./templates/ex_10/austrian_patient-example01.fsh)

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Deployment in der HL7 Austria IG Infrastruktur
Für das Deployment eines FHIR&reg;-Implementierungsleitfadens in der HL7 Austria IG Infrastruktur gilt es sowohl organisatorische, als auch technische Voraussetzungen zu erfüllen. Was die organisatorischen Voraussetzungen betrifft, kann hier das Zuständige technische Kommittee unter tc-fhir@hl7.at weiterhelfen. 

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Deployment in der HL7 Austria IG Infrastruktur
- Die HL7 Austria Infrastruktur scant registrierte Implementierungsleitfäden auf das Vorhandensein einer speziellen Konfigurationsdatei. Diese Datei, ist im Verzeichnis '/input/landing-page' als `_index.yml` anzulegen.

```bash
/ig-eMedication-at
    ├── input                  
      ├── landing-page
        ├── index.yml
```
&nbsp;

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Deployment in der HL7 Austria IG Infrastruktur
- Die Datei `index.yml` enthält sog. Projektkoordinaten, d.s. unter anderem Details zum Namen und der Version des entsprechenden Implementierungsleitfadens

```yaml
- name: HL7 IG Infrastructure Workshop
- version: 0.1.0
- description: Sample Implementation Guide for the annual HL7&reg; Austria meeting workshops.
- last_published: %%date%%
- branch: %%branch%%
- type: draft
```
&nbsp;

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Deployment in der HL7 Austria IG Infrastruktur
- Nebst dem Namen, der Version und der Beschreibung des Implementierungsleitfaden werden Daten zum letzten Zeitpunkt der Veröffentlichung, der jeweilige Branch (Git-Branch) sowie den Typ des jeweiligen Repositories. 
- Gültige Werte für letzters sind `draft|official|main` 
    - für `main` gilt: Diese werden unter fhir.hl7.at im Bereich *HL7 Austria Member IGs* angezeigt.
    - für `draft` gilt: Dieser werden unter fhir.hl7.at im Bereich *Working Drafts* angezeigt. 
    - `official` ist für Leitfäden der HL7 Austria vorbehalten

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Deployment in der HL7 Austria IG Infrastruktur
- <span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">1</span> Nachdem die Datei ergänzt wurde, kann der Implementierungsleitfaden in das zur Verfügung gestellte Git-Repository gepushed werden. Als Teil der organistorischen Voraussetzungen, wird das entsprechende Repository mit einer GitHub-Action versehen, die beim Atkualisieren einzelner Branches, bspw. durch Commit und anschließendem Push angestoßen wird. 

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Deployment in der HL7 Austria IG Infrastruktur
- <span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">2</span> Diese Action prüft, ob alle technischen Voraussetzungen gegeben sind und erstellt ein IG Paket, das in das hl7austria.github.io Repository deployed wird. 

<!-- .slide -->
# Erstellen von HL7&reg; FHIR&reg; *ImplementationGuides*
## Beispiele
***
### Deployment in der HL7 Austria IG Infrastruktur
- <span style="border-radius: 3px;background-color:rgba(17, 173, 221, 1); padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">3</span> Abschließend wird von entsprechendem Repository ein Deployment des Implementierungsleitfadens auf fhir.hl7.at vollzogen. Nach erfolgtem Deployment kann der Implementierungsleitfaden unter fhir.hl7.at angezeigt und ausgewählt werden.

<span style="border-radius: 3px;background-color:orange; padding:2px 6px 2px 6px;color:#FFF;font-family: Panic Sans, Consolas, monospace;">i</span> Dieser Ablauf wird für alle Branches im Quell-Repository durchgeführt. Sofern ein bestimmter Branch nicht deployed werden soll, so kann dies durch Entfernen der `_index.yml` Datei für diesen Branch erfolgen 
