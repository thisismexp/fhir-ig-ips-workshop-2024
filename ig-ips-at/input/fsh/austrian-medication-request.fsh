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