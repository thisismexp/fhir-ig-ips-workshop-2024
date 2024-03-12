Alias: $usage-context-type = http://terminology.hl7.org/CodeSystem/usage-context-type
Alias: $variant-state = http://terminology.hl7.org/CodeSystem/variant-state
Alias: $restful-security-service = http://terminology.hl7.org/CodeSystem/restful-security-service
Alias: $message-transport = http://terminology.hl7.org/CodeSystem/message-transport

Instance: HL7ATCoreIPSCapabilities
InstanceOf: CapabilityStatement
Title:          "HL7® AT Core IPS Capabilities"
Description:    "HL7® Austria FHIR® Core Capabilities for accessing Austrian Patient resource."

Usage: #definition
* name = "HL7® AT Core IPS Capabilities"
* title = "HL7® AT Core IPS Capabilities"
* status = #draft
* experimental = true
* date = "2024-02-28"
* publisher = "HL7® Austria"
* contact.name = "HL7® Austria Technical Committee FHIR"
* contact.telecom.system = #email
* contact.telecom.value = "tc-fhir@hl7.at"
* description = "This is the FHIR capability statement for the Core Austrian Patient"
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #xml
* format[+] = #json
* implementationGuide[0] = "http://hl7.at/fhir/HL7ATCoreProfiles/4.0.1" 
* implementationGuide[+] = "http://fhir.hl7.at/ips-at"
* rest.mode = #server
* rest.security.cors = true
* rest.security.service = $restful-security-service#OAuth
* rest.security.description = "See OAuth specification."
* rest.resource.type = #MedicationRequest
* rest.resource.profile = "http://fhir.hl7.at/ips-at/StructureDefinition/austrian-medication-request"
* rest.resource.supportedProfile = "http://fhir.hl7.at/ips-at/StructureDefinition/austrian-medication-request"
* rest.resource.documentation = "This server does not let the clients create identities."
* rest.resource.interaction[0].code = #read
* rest.resource.readHistory = false
* rest.resource.updateCreate = false
* rest.resource.conditionalCreate = false
* rest.resource.conditionalRead = #full-support
* rest.resource.conditionalUpdate = false
* rest.resource.conditionalDelete = #not-supported
* rest.resource.searchParam[0].name = "subject"
* rest.resource.searchParam[=].type = #reference
