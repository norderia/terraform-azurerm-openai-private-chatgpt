[![Manual-Tests-and-Release](https://github.com/Pwd9000-ML/terraform-azurerm-openai-private-chatgpt/actions/workflows/manual-test-release.yml/badge.svg)](https://github.com/Pwd9000-ML/terraform-azurerm-openai-private-chatgpt/actions/workflows/manual-test-release.yml) [![Automated-Dependency-Tests-and-Release](https://github.com/Pwd9000-ML/terraform-azurerm-openai-private-chatgpt/actions/workflows/dependency-tests.yml/badge.svg)](https://github.com/Pwd9000-ML/terraform-azurerm-openai-private-chatgpt/actions/workflows/dependency-tests.yml) [![Dependabot](https://badgen.net/badge/Dependabot/enabled/green?icon=dependabot)](https://dependabot.com/)

# Module: Azure OpenAI Private ChatGPT

## Current Version 2.x

Version **2.x** a complete rewrite of the module and is not backwards compatible with version **1.x.**  
New integrations and features have been added to the module to use the latest **Azure OpenAI** services and features such as `GPT-4-1106`, `GPT-4-Vision` and `DALL-E-3`. A new ChatBot UI / [LibreChat](https://docs.librechat.ai/index.html) has been added to the module to provide a complete solution.  

[![LIBRE](https://img.youtube.com/vi/pNIOs1ovsXw/0.jpg)](https://www.youtube.com/watch?v=pNIOs1ovsXw)  

## Legacy Version 1.x

**NOTE:** Legacy version **1.x** can be found in the legacy branch **[here](https://github.com/Pwd9000-ML/terraform-azurerm-openai-private-chatgpt/tree/legacy-v1)**  

**[Version 1.x Documentation](https://github.com/Pwd9000-ML/terraform-azurerm-openai-private-chatgpt/blob/legacy-v1/README.md)**  

## Introduction

Under **OpenAI's** terms when using the public version of **ChatGPT**, any questions you pose—referred to as **"prompts"**—may contribute to the further training of OpenAI's Large Language Model (LLM). Given this, it's crucial to ask: Are you comfortable with this precious data flow leaving your organization? If you're a decision-maker or hold responsibility over your organization's security measures, what steps are you taking to ensure proprietary information remains confidential?  

An effective solution lies in utilising a hosted version of the popular LLM on **Azure OpenAI**. While there are numerous advantages to Azure OpenAI, I'd like to spotlight two:

- **Data Privacy**: By hosting OpenAI's models on Azure, your prompts will never serve as a source for training the LLM. It's simply a self-contained version running on Azure tailored for your use.

- **Enhanced Security**: Azure OpenAI offers robust security measures, from the capability to secure specific endpoints to intricate role-based access controls.
For a deeper dive, refer to this [Microsoft Learn article](https://learn.microsoft.com/en-us/azure/ai-services/openai/overview).  

While Azure OpenAI does come with a cost, it's highly affordable—often, a conversation costs under 10 cents. You can review Azure [OpenAI's pricing](https://azure.microsoft.com/en-us/pricing/details/cognitive-services/openai-service/) details here.

## Diagram

coming soon...

## Description

coming soon...

## ChatBot Demo

coming soon...

## Examples

coming soon...

Enjoy!  

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.87.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure_frontdoor_cdn"></a> [azure\_frontdoor\_cdn](#module\_azure\_frontdoor\_cdn) | ./modules/cdn_frontdoor | n/a |
| <a name="module_openai"></a> [openai](#module\_openai) | Pwd9000-ML/openai-service/azurerm | >= 1.1.0 |
| <a name="module_privategpt_chatbot_container_apps"></a> [privategpt\_chatbot\_container\_apps](#module\_privategpt\_chatbot\_container\_apps) | ./modules/container_app | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ca_container_config"></a> [ca\_container\_config](#input\_ca\_container\_config) | type = object({<br>  name                    = (Required) The name of the container.<br>  image                   = (Required) The name of the container image.<br>  cpu                     = (Required) The number of CPU cores to allocate to the container.<br>  memory                  = (Required) The amount of memory to allocate to the container in GB.<br>  min\_replicas            = (Optional) The minimum number of replicas to run. Defaults to `0`.<br>  max\_replicas            = (Optional) The maximum number of replicas to run. Defaults to `10`.<br>  env = list(object({<br>    name        = (Required) The name of the environment variable.<br>    secret\_name = (Optional) The name of the secret to use for the environment variable.<br>    value       = (Optional) The value of the environment variable.<br>  }))<br>}) | <pre>object({<br>    name         = string<br>    image        = string<br>    cpu          = number<br>    memory       = string<br>    min_replicas = optional(number, 0)<br>    max_replicas = optional(number, 10)<br>    env = optional(list(object({<br>      name        = string<br>      secret_name = optional(string)<br>      value       = optional(string)<br>    })))<br>  })</pre> | <pre>{<br>  "cpu": 1,<br>  "env": [],<br>  "image": "ghcr.io/pwd9000-ml/chatbot-ui:main",<br>  "max_replicas": 10,<br>  "memory": "2Gi",<br>  "min_replicas": 0,<br>  "name": "gpt-chatbot-ui"<br>}</pre> | no |
| <a name="input_ca_identity"></a> [ca\_identity](#input\_ca\_identity) | type = object({<br>  type         = (Required) The type of the Identity. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`.<br>  identity\_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this OpenAI Account.<br>}) | <pre>object({<br>    type         = string<br>    identity_ids = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_ca_ingress"></a> [ca\_ingress](#input\_ca\_ingress) | type = object({<br>  allow\_insecure\_connections = (Optional) Allow insecure connections to the container app. Defaults to `false`.<br>  external\_enabled           = (Optional) Enable external access to the container app. Defaults to `true`.<br>  target\_port                = (Required) The port to use for the container app. Defaults to `3000`.<br>  transport                  = (Optional) The transport protocol to use for the container app. Defaults to `auto`.<br>  type = object({<br>    percentage      = (Required) The percentage of traffic to route to the container app. Defaults to `100`.<br>    latest\_revision = (Optional) The percentage of traffic to route to the container app. Defaults to `true`.<br>  }) | <pre>object({<br>    allow_insecure_connections = optional(bool)<br>    external_enabled           = optional(bool)<br>    target_port                = number<br>    transport                  = optional(string)<br>    traffic_weight = optional(object({<br>      percentage      = number<br>      latest_revision = optional(bool)<br>    }))<br>  })</pre> | <pre>{<br>  "allow_insecure_connections": false,<br>  "external_enabled": true,<br>  "target_port": 3000,<br>  "traffic_weight": {<br>    "latest_revision": true,<br>    "percentage": 100<br>  },<br>  "transport": "auto"<br>}</pre> | no |
| <a name="input_ca_name"></a> [ca\_name](#input\_ca\_name) | Name of the container app to create. | `string` | `"gptca"` | no |
| <a name="input_ca_resource_group_name"></a> [ca\_resource\_group\_name](#input\_ca\_resource\_group\_name) | Name of the resource group to create the Container App and supporting solution resources in. | `string` | n/a | yes |
| <a name="input_ca_revision_mode"></a> [ca\_revision\_mode](#input\_ca\_revision\_mode) | Revision mode of the container app to create. | `string` | `"Single"` | no |
| <a name="input_ca_secrets"></a> [ca\_secrets](#input\_ca\_secrets) | type = list(object({<br>  name  = (Required) The name of the secret.<br>  value = (Required) The value of the secret.<br>})) | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "secret1",<br>    "value": "value1"<br>  },<br>  {<br>    "name": "secret2",<br>    "value": "value2"<br>  }<br>]</pre> | no |
| <a name="input_cae_name"></a> [cae\_name](#input\_cae\_name) | Name of the container app environment to create. | `string` | `"gptcae"` | no |
| <a name="input_cdn_endpoint"></a> [cdn\_endpoint](#input\_cdn\_endpoint) | typp = object({<br>      name    = (Required) The name of the CDN endpoint to create.<br>      enabled = (Optional) Is the CDN endpoint enabled? Defaults to `true`.<br>    }) | <pre>object({<br>    name    = string<br>    enabled = optional(bool, true)<br>  })</pre> | <pre>{<br>  "enabled": true,<br>  "name": "PrivateGPT"<br>}</pre> | no |
| <a name="input_cdn_firewall_policy"></a> [cdn\_firewall\_policy](#input\_cdn\_firewall\_policy) | The CDN firewall policies to create. | <pre>object({<br>    create_waf                        = bool<br>    name                              = string<br>    enabled                           = optional(bool, true)<br>    mode                              = optional(string, "Prevention")<br>    redirect_url                      = optional(string)<br>    custom_block_response_status_code = optional(number, 403)<br>    custom_block_response_body        = optional(string)<br>    custom_rules = optional(list(object({<br>      name                           = string<br>      action                         = string<br>      enabled                        = optional(bool, true)<br>      priority                       = number<br>      type                           = string<br>      rate_limit_duration_in_minutes = optional(number, 1)<br>      rate_limit_threshold           = optional(number, 10)<br>      match_conditions = list(object({<br>        match_variable     = string<br>        match_values       = list(string)<br>        operator           = string<br>        selector           = optional(string)<br>        negation_condition = optional(bool)<br>        transforms         = optional(list(string))<br>      }))<br>    })))<br>  })</pre> | <pre>{<br>  "create_waf": true,<br>  "custom_block_response_body": "WW91ciByZXF1ZXN0IGhhcyBiZWVuIGJsb2NrZWQu",<br>  "custom_block_response_status_code": 403,<br>  "custom_rules": [<br>    {<br>      "action": "Block",<br>      "enabled": true,<br>      "match_conditions": [<br>        {<br>          "match_values": [<br>            "10.0.1.0/24",<br>            "10.0.2.0/24"<br>          ],<br>          "match_variable": "RemoteAddr",<br>          "negation_condition": null,<br>          "operator": "IPMatch",<br>          "selector": null,<br>          "transforms": []<br>        }<br>      ],<br>      "name": "PrivateGPTFirewallPolicyCustomRule",<br>      "priority": 100,<br>      "rate_limit_duration_in_minutes": 1,<br>      "rate_limit_threshold": 10,<br>      "type": "MatchRule"<br>    }<br>  ],<br>  "enabled": true,<br>  "mode": "Prevention",<br>  "name": "PrivateGPTFirewallPolicy",<br>  "redirect_url": null<br>}</pre> | no |
| <a name="input_cdn_gpt_origin"></a> [cdn\_gpt\_origin](#input\_cdn\_gpt\_origin) | type = object({<br>  name                           = (Required) The name which should be used for this Front Door Origin. Changing this forces a new Front Door Origin to be created.<br>  origin\_group\_name              = (Required) The name of the CDN origin group to associate this origin with.<br>  enabled                        = (Optional) Is the CDN origin enabled? Defaults to `true`.<br>  certificate\_name\_check\_enabled = (Required) Specifies whether certificate name checks are enabled for this origin. Defaults to `true`.<br>  http\_port                      = (Optional) The HTTP port of the origin. (e.g. 80)<br>  https\_port                     = (Optional) The HTTPS port of the origin. (e.g. 443)<br>  priority                       = (Optional) The priority of the origin. (e.g. 1)<br>  weight                         = (Optional) The weight of the origin. (e.g. 1000)<br>}) | <pre>object({<br>    name                           = string<br>    origin_group_name              = string<br>    enabled                        = optional(bool, true)<br>    certificate_name_check_enabled = optional(bool, true)<br>    http_port                      = optional(number, 80)<br>    https_port                     = optional(number, 443)<br>    priority                       = optional(number, 1)<br>    weight                         = optional(number, 1000)<br>  })</pre> | <pre>{<br>  "certificate_name_check_enabled": true,<br>  "enabled": true,<br>  "http_port": 80,<br>  "https_port": 443,<br>  "name": "PrivateGPTOrigin",<br>  "origin_group_name": "PrivateGPTOriginGroup",<br>  "priority": 1,<br>  "weight": 1000<br>}</pre> | no |
| <a name="input_cdn_origin_groups"></a> [cdn\_origin\_groups](#input\_cdn\_origin\_groups) | type = list(object({<br>  name                                                      = (Required) The name of the CDN origin group to create.<br>  session\_affinity\_enabled                                  = (Optional) Is session affinity enabled? Defaults to `false`.<br>  restore\_traffic\_time\_to\_healed\_or\_new\_endpoint\_in\_minutes = (Optional) The time in minutes to restore traffic to a healed or new endpoint. Defaults to `5`.<br>  health\_probe = (Optional) The health probe settings.<br>  type = object({<br>    interval\_in\_seconds = (Optional) The interval in seconds between health probes. Defaults to `100`.<br>    path                = (Optional) The path to use for health probes. Defaults to `/`.<br>    protocol            = (Optional) The protocol to use for health probes. Possible values include 'Http' and 'Https'. Defaults to `Http`.<br>    request\_type        = (Optional) The request type to use for health probes. Possible values include 'GET', 'HEAD', and 'OPTIONS'. Defaults to `HEAD`.<br>  }))<br>  load\_balancing = (Optional) The load balancing settings.<br>  type = object({<br>    additional\_latency\_in\_milliseconds = (Optional) The additional latency in milliseconds for probes to fall into the lowest latency bucket. Defaults to `50`.<br>    sample\_size                        = (Optional) The number of samples to take for load balancing decisions. Defaults to `4`.<br>    successful\_samples\_required        = (Optional) The number of samples within the sample period that must succeed. Defaults to `3`.<br>  }))<br>})) | <pre>list(object({<br>    name                                                      = string<br>    session_affinity_enabled                                  = optional(bool, false)<br>    restore_traffic_time_to_healed_or_new_endpoint_in_minutes = optional(number, 5)<br>    health_probe = optional(object({<br>      interval_in_seconds = optional(number, 100)<br>      path                = optional(string, "/")<br>      protocol            = optional(string, "Http")<br>      request_type        = optional(string, "HEAD")<br>    }))<br>    load_balancing = optional(object({<br>      additional_latency_in_milliseconds = optional(number, 50)<br>      sample_size                        = optional(number, 4)<br>      successful_samples_required        = optional(number, 3)<br>    }))<br>  }))</pre> | <pre>[<br>  {<br>    "health_probe": {<br>      "interval_in_seconds": 100,<br>      "path": "/",<br>      "protocol": "Http",<br>      "request_type": "HEAD"<br>    },<br>    "load_balancing": {<br>      "additional_latency_in_milliseconds": 50,<br>      "sample_size": 4,<br>      "successful_samples_required": 3<br>    },<br>    "name": "PrivateGPTOriginGroup",<br>    "restore_traffic_time_to_healed_or_new_endpoint_in_minutes": 5,<br>    "session_affinity_enabled": false<br>  }<br>]</pre> | no |
| <a name="input_cdn_profile_name"></a> [cdn\_profile\_name](#input\_cdn\_profile\_name) | The name of the CDN profile to create. | `string` | `"example-cdn-profile"` | no |
| <a name="input_cdn_resource_group_name"></a> [cdn\_resource\_group\_name](#input\_cdn\_resource\_group\_name) | Name of the resource group to create the CDN Front Door in. | `string` | `"cdn-rg-01"` | no |
| <a name="input_cdn_route"></a> [cdn\_route](#input\_cdn\_route) | type = object({<br>  name                           = (Required) The name of the CDN route to create.<br>  enabled                        = (Optional) Is the CDN route enabled? Defaults to `true`.<br>  forwarding\_protocol            = (Optional) The protocol this rule will use when forwarding traffic to backends. Possible values include `MatchRequest`, `HttpOnly` and `HttpsOnly`. Defaults to `HttpsOnly`.<br>  https\_redirect\_enabled         = (Optional) Is HTTPS redirect enabled? Defaults to `false`.<br>  patterns\_to\_match              = (Optional) The list of patterns to match for this rule. Defaults to `["/*"]`.<br>  supported\_protocols            = (Optional) The list of supported protocols for this rule. Defaults to `["Http", "Https"]`.<br>  cdn\_frontdoor\_origin\_path      = (Optional) The path to use when forwarding traffic to backends. Defaults to `null`.<br>  cdn\_frontdoor\_rule\_set\_ids     = (Optional) The list of rule set IDs to associate with this rule. Defaults to `null`.<br>  link\_to\_default\_domain         = (Optional) Is the CDN route linked to the default domain? Defaults to `false`.<br>  cache = (Optional) The CDN route cache settings.<br>  type = object({<br>    query\_string\_caching\_behavior = (Required) The query string caching behavior. Possible values include 'IgnoreQueryString', 'BypassCaching', 'UseQueryString', and 'NotSet'. Defaults to 'IgnoreQueryString'.<br>    query\_strings                 = (Optional) The list of query strings to include or exclude from caching. Defaults to `[]`.<br>    compression\_enabled           = (Required) Is compression enabled? Defaults to `false`.<br>    content\_types\_to\_compress     = (Optional) The list of content types to compress. Defaults to `[]`.<br>  })<br>}) | <pre>object({<br>    name                       = string<br>    enabled                    = optional(bool, true)<br>    forwarding_protocol        = optional(string, "HttpsOnly")<br>    https_redirect_enabled     = optional(bool, false)<br>    patterns_to_match          = optional(list(string), ["/*"])<br>    supported_protocols        = optional(list(string), ["Http", "Https"])<br>    cdn_frontdoor_origin_path  = optional(string, null)<br>    cdn_frontdoor_rule_set_ids = optional(list(string), null)<br>    link_to_default_domain     = optional(bool, false)<br>    cache = optional(object({<br>      query_string_caching_behavior = string<br>      query_strings                 = optional(list(string), [])<br>      compression_enabled           = bool<br>      content_types_to_compress     = optional(list(string), [])<br>    }))<br>  })</pre> | <pre>{<br>  "cache": {<br>    "compression_enabled": false,<br>    "content_types_to_compress": [],<br>    "query_string_caching_behavior": "IgnoreQueryString",<br>    "query_strings": []<br>  },<br>  "cdn_frontdoor_origin_path": null,<br>  "cdn_frontdoor_rule_set_ids": null,<br>  "enabled": true,<br>  "forwarding_protocol": "HttpsOnly",<br>  "https_redirect_enabled": false,<br>  "link_to_default_domain": false,<br>  "name": "PrivateGPTRoute",<br>  "patterns_to_match": [<br>    "/*"<br>  ],<br>  "supported_protocols": [<br>    "Http",<br>    "Https"<br>  ]<br>}</pre> | no |
| <a name="input_cdn_security_policy"></a> [cdn\_security\_policy](#input\_cdn\_security\_policy) | type = object({<br>  name                 = (Required) The name of the CDN security policy to create.<br>  patterns\_to\_match    = (Required) The list of patterns to match for this policy. Defaults to `["/*"]`.<br>}) | <pre>object({<br>    name              = string<br>    patterns_to_match = list(string)<br>  })</pre> | <pre>{<br>  "name": "PrivateGPTSecurityPolicy",<br>  "patterns_to_match": [<br>    "/*"<br>  ]<br>}</pre> | no |
| <a name="input_cdn_sku_name"></a> [cdn\_sku\_name](#input\_cdn\_sku\_name) | Specifies the SKU for the CDN Front Door Profile. Possible values include 'Standard\_AzureFrontDoor' and 'Premium\_AzureFrontDoor'. | `string` | `"Standard_AzureFrontDoor"` | no |
| <a name="input_create_dns_zone"></a> [create\_dns\_zone](#input\_create\_dns\_zone) | Create a DNS zone for the CDN profile. If set to false, an existing DNS zone must be provided. | `bool` | `false` | no |
| <a name="input_create_front_door_cdn"></a> [create\_front\_door\_cdn](#input\_create\_front\_door\_cdn) | Create a Front Door profile. | `bool` | `false` | no |
| <a name="input_create_model_deployment"></a> [create\_model\_deployment](#input\_create\_model\_deployment) | Create the model deployment. | `bool` | `false` | no |
| <a name="input_create_openai_service"></a> [create\_openai\_service](#input\_create\_openai\_service) | Create the OpenAI service. | `bool` | `false` | no |
| <a name="input_custom_domain_config"></a> [custom\_domain\_config](#input\_custom\_domain\_config) | type = object({<br>  zone\_name = (Required) The name of the DNS zone to create the CNAME and TXT record in for the CDN Front Door Custom domain.<br>  host\_name = (Required) The host name of the DNS record to create. (e.g. Contoso)<br>  ttl       = (Optional) The TTL of the DNS record to create. (e.g. 3600)<br>  tls       = optional(list(object({<br>    certificate\_type    = (Optional) Defines the source of the SSL certificate. Possible values include 'CustomerCertificate' and 'ManagedCertificate'. Defaults to 'ManagedCertificate'.<br>    NOTE: It may take up to 15 minutes for the Front Door Service to validate the state and Domain ownership of the Custom Domain.<br>    minimum\_tls\_version = (Optional) TLS protocol version that will be used for Https. Possible values include TLS10 and TLS12. Defaults to TLS12.<br>  }))))<br>}) | <pre>object({<br>    zone_name = string<br>    host_name = string<br>    ttl       = optional(number, 3600)<br>    tls = optional(list(object({<br>      certificate_type    = optional(string, "ManagedCertificate")<br>      minimum_tls_version = optional(string, "TLS12")<br>    })))<br>  })</pre> | <pre>{<br>  "host_name": "PrivateGPT",<br>  "tls": [<br>    {<br>      "certificate_type": "ManagedCertificate",<br>      "minimum_tls_version": "TLS12"<br>    }<br>  ],<br>  "ttl": 3600,<br>  "zone_name": "mydomain7335.com"<br>}</pre> | no |
| <a name="input_dns_resource_group_name"></a> [dns\_resource\_group\_name](#input\_dns\_resource\_group\_name) | The name of the resource group to create the DNS zone in / or where the existing zone is hosted. | `string` | `"dns-rg-01"` | no |
| <a name="input_key_vault_access_permission"></a> [key\_vault\_access\_permission](#input\_key\_vault\_access\_permission) | The permission to grant the container app to the key vault. Set this variable to `null` if no Key Vault access is needed. Defaults to `Key Vault Secrets User`. | `list(string)` | <pre>[<br>  "Key Vault Secrets User"<br>]</pre> | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | (Optional) - The id of the key vault to grant access to. Only required if `key_vault_access_permission` is set. | `string` | `""` | no |
| <a name="input_keyvault_firewall_allowed_ips"></a> [keyvault\_firewall\_allowed\_ips](#input\_keyvault\_firewall\_allowed\_ips) | value of key vault firewall allowed ip rules. | `list(string)` | `[]` | no |
| <a name="input_keyvault_firewall_bypass"></a> [keyvault\_firewall\_bypass](#input\_keyvault\_firewall\_bypass) | List of key vault firewall rules to bypass. | `string` | `"AzureServices"` | no |
| <a name="input_keyvault_firewall_default_action"></a> [keyvault\_firewall\_default\_action](#input\_keyvault\_firewall\_default\_action) | Default action for key vault firewall rules. | `string` | `"Deny"` | no |
| <a name="input_keyvault_firewall_virtual_network_subnet_ids"></a> [keyvault\_firewall\_virtual\_network\_subnet\_ids](#input\_keyvault\_firewall\_virtual\_network\_subnet\_ids) | value of key vault firewall allowed virtual network subnet ids. | `list(string)` | `[]` | no |
| <a name="input_keyvault_resource_group_name"></a> [keyvault\_resource\_group\_name](#input\_keyvault\_resource\_group\_name) | Name of the resource group to create the Key Vault that will store OpenAI service account details. | `string` | n/a | yes |
| <a name="input_kv_config"></a> [kv\_config](#input\_kv\_config) | Key Vault configuration object to create azure key vault to store openai account details. | <pre>object({<br>    name = string<br>    sku  = string<br>  })</pre> | <pre>{<br>  "name": "kvname",<br>  "sku": "standard"<br>}</pre> | no |
| <a name="input_laws_name"></a> [laws\_name](#input\_laws\_name) | Name of the log analytics workspace to create. | `string` | `"gptlaws"` | no |
| <a name="input_laws_retention_in_days"></a> [laws\_retention\_in\_days](#input\_laws\_retention\_in\_days) | Retention in days of the log analytics workspace to create. | `number` | `30` | no |
| <a name="input_laws_sku"></a> [laws\_sku](#input\_laws\_sku) | SKU of the log analytics workspace to create. | `string` | `"PerGB2018"` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region where resources will be hosted. | `string` | `"uksouth"` | no |
| <a name="input_model_deployment"></a> [model\_deployment](#input\_model\_deployment) | type = list(object({<br>  deployment\_id   = (Required) The name of the Cognitive Services Account `Model Deployment`. Changing this forces a new resource to be created.<br>  model\_name = {<br>    model\_format  = (Required) The format of the Cognitive Services Account Deployment model. Changing this forces a new resource to be created. Possible value is OpenAI.<br>    model\_name    = (Required) The name of the Cognitive Services Account Deployment model. Changing this forces a new resource to be created.<br>    model\_version = (Required) The version of Cognitive Services Account Deployment model.<br>  }<br>  scale = {<br>    scale\_type     = (Required) Deployment scale type. Possible value is Standard. Changing this forces a new resource to be created.<br>    scale\_tier     = (Optional) Possible values are Free, Basic, Standard, Premium, Enterprise. Changing this forces a new resource to be created.<br>    scale\_size     = (Optional) The SKU size. When the name field is the combination of tier and some other value, this would be the standalone code. Changing this forces a new resource to be created.<br>    scale\_family   = (Optional) If the service has different generations of hardware, for the same SKU, then that can be captured here. Changing this forces a new resource to be created.<br>    scale\_capacity = (Optional) Tokens-per-Minute (TPM). If the SKU supports scale out/in then the capacity integer should be included. If scale out/in is not possible for the resource this may be omitted. Default value is 1. Changing this forces a new resource to be created.<br>  }<br>  rai\_policy\_name = (Optional) The name of RAI policy. Changing this forces a new resource to be created.<br>})) | <pre>list(object({<br>    deployment_id   = string<br>    model_name      = string<br>    model_format    = string<br>    model_version   = string<br>    scale_type      = string<br>    scale_tier      = optional(string)<br>    scale_size      = optional(number)<br>    scale_family    = optional(string)<br>    scale_capacity  = optional(number)<br>    rai_policy_name = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_openai_account_name"></a> [openai\_account\_name](#input\_openai\_account\_name) | Name of the OpenAI service. | `string` | `"demo-account"` | no |
| <a name="input_openai_custom_subdomain_name"></a> [openai\_custom\_subdomain\_name](#input\_openai\_custom\_subdomain\_name) | The subdomain name used for token-based authentication. Changing this forces a new resource to be created. (normally the same as the account name) | `string` | `"demo-account"` | no |
| <a name="input_openai_identity"></a> [openai\_identity](#input\_openai\_identity) | type = object({<br>  type         = (Required) The type of the Identity. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned`.<br>  identity\_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this OpenAI Account.<br>}) | <pre>object({<br>    type = string<br>  })</pre> | <pre>{<br>  "type": "SystemAssigned"<br>}</pre> | no |
| <a name="input_openai_local_auth_enabled"></a> [openai\_local\_auth\_enabled](#input\_openai\_local\_auth\_enabled) | Whether local authentication methods is enabled for the Cognitive Account. Defaults to `true`. | `bool` | `true` | no |
| <a name="input_openai_outbound_network_access_restricted"></a> [openai\_outbound\_network\_access\_restricted](#input\_openai\_outbound\_network\_access\_restricted) | Whether or not outbound network access is restricted. Defaults to `false`. | `bool` | `false` | no |
| <a name="input_openai_public_network_access_enabled"></a> [openai\_public\_network\_access\_enabled](#input\_openai\_public\_network\_access\_enabled) | Whether or not public network access is enabled. Defaults to `false`. | `bool` | `true` | no |
| <a name="input_openai_resource_group_name"></a> [openai\_resource\_group\_name](#input\_openai\_resource\_group\_name) | Name of the resource group to create the OpenAI service / or where an existing service is hosted. | `string` | n/a | yes |
| <a name="input_openai_sku_name"></a> [openai\_sku\_name](#input\_openai\_sku\_name) | SKU name of the OpenAI service. | `string` | `"S0"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of key value pairs that is used to tag resources created. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_app_enviornment_id"></a> [container\_app\_enviornment\_id](#output\_container\_app\_enviornment\_id) | The ID of the container app enviornment. |
| <a name="output_container_app_id"></a> [container\_app\_id](#output\_container\_app\_id) | The ID of the container app. |
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | The ID of the Key Vault used to store OpenAI account and model details. |
| <a name="output_key_vault_uri"></a> [key\_vault\_uri](#output\_key\_vault\_uri) | The URI of the Key Vault used to store OpenAI account and model details.. |
| <a name="output_latest_revision_fqdn"></a> [latest\_revision\_fqdn](#output\_latest\_revision\_fqdn) | The FQDN of the Latest Revision of the Container App. |
| <a name="output_latest_revision_name"></a> [latest\_revision\_name](#output\_latest\_revision\_name) | The Name of the Latest Revision of the Container App. |
| <a name="output_openai_account_name"></a> [openai\_account\_name](#output\_openai\_account\_name) | The name of the Cognitive Service Account. |
| <a name="output_openai_endpoint"></a> [openai\_endpoint](#output\_openai\_endpoint) | The endpoint used to connect to the Cognitive Service Account. |
| <a name="output_openai_primary_key"></a> [openai\_primary\_key](#output\_openai\_primary\_key) | The primary access key for the Cognitive Service Account. |
| <a name="output_openai_secondary_key"></a> [openai\_secondary\_key](#output\_openai\_secondary\_key) | The secondary access key for the Cognitive Service Account. |
| <a name="output_openai_subdomain"></a> [openai\_subdomain](#output\_openai\_subdomain) | The subdomain used to connect to the Cognitive Service Account. |
<!-- END_TF_DOCS -->