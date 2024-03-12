Alias: $austrian-patient = http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1/StructureDefinition/at-core-patient
Alias: $impose-profile = http://hl7.org/fhir/StructureDefinition/structuredefinition-imposeProfile
/*##############################################################################
# Type:       FSH-File for an FHIR® Profile
# About:      HL7® Austria FHIR® Core Profile for Patient.
# Created by: HL7® Austria, TC FHIR®
##############################################################################*/
Profile: AustrianIPSPatient
Parent: PatientUvIps
Id: at-core-ips-patient
Title:          "HL7® AT Core Patient Profile for IPS"
Description:    "HL7® Austria FHIR® Core Profile for patient data in Austria within the context of the IPS.
The HL7® AT Core Patient is based upon the core FHIR® Patient Resource and designed to meet the applicable patient demographic data elements in Austria. It identifies which core elements, extensions, vocabularies and value sets SHALL be present in the resource when using this profile. Note, this extension represents the common structure of Patient information within Austrian information systems."
* name 1..* MS
//* link.other only Reference($austrian-patient)
* ^extension[$impose-profile].valueCanonical = Canonical($austrian-patient)
