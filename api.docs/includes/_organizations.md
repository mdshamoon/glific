# Organizations

## Get All Organizations

```graphql
query organizations($filter: OrganizationFilter, $opts: Opts) {
  organizations(filter: $filter, opts: $opts) {
    id
    name
    defaultLanguage {
      id
      label
    }
    activeLanguages {
      id
      label
    }
    isActive
    timezone
  }
}

{
  "opts": {
    "limit": 10,
    "offset": 1,
    "order": "ASC"
  },
  "filter": {
    "defaultLanguage": "Hindi"
  }
}
```

> The above query returns JSON structured like this:

```json
{
  "data": {
    "organizations": [
      {
        "activeLanguages": [
          {
            "id": "1",
            "label": "Hindi"
          },
          {
            "id": "2",
            "label": "English"
          }
        ],
        "defaultLanguage": {
          "id": "1",
          "label": "Hindi"
        },
        "id": "1",
        "name": "Default Organization",
        "isActive": true,
        "timezone": "Asia/Kolkata"
      },
      {
        "defaultLanguage": {
          "id": "1",
          "label": "Hindi"
        },
        "id": "2",
        "name": "Slam Out Loud",
        "isActive": true,
        "timezone": "Asia/Kolkata"
      }
    ]
  }
}
```

This returns all the organizations filtered by the input <a href="#organizationfilter">OrganizationFilter</a>

### Query Parameters

| Parameter | Type                                                 | Default | Description                         |
| --------- | ---------------------------------------------------- | ------- | ----------------------------------- |
| filter    | <a href="#organizationfilter">OrganizationFilter</a> | nil     | filter the list                     |
| opts      | <a href="#opts">Opts</a>                             | nil     | limit / offset / sort order options |

### Return Parameters

| Type                                       | Description          |
| ------------------------------------------ | -------------------- |
| [<a href="#organization">Organization</a>] | List of organization |

## Get a specific Organization by ID

```graphql
query organization($id: ID) {
  organization(id: $id) {
    organization {
      id
      name
      isActive
      timezone
      defaultLanguage {
        id
        label
      }
    }
  }
}

{
  "id": 1
}
```

> The above query returns JSON structured like this:

```json
{
  "data": {
    "organization": {
      "organization": {
        "defaultLanguage": {
          "id": "1",
          "label": "Hindi"
        },
        "id": "1",
        "name": "Default Organization",
        "isActive": true,
        "timezone": "Asia/Kolkata"
      }
    }
  }
}
```

> Get current user's organization details

```graphql
query organization {
  organization {
    organization {
      id
      name
    }
  }
}
```

### Query Parameters

| Parameter | Type                 | Default | Description |
| --------- | -------------------- | ------- | ----------- |
| id        | <a href="#id">ID</a> |         |

### Return Parameters

| Type                                                 | Description                                         |
| ---------------------------------------------------- | --------------------------------------------------- |
| <a href="#organizationresult">OrganizationResult</a> | Queried organization or Current user's organization |

## Get Organization Services

```graphql
query organizationServices() {
  bigquery
  dialogflow
  googleCloudStorage
  errors {
    key
    message
  }
}
```

> The above query returns JSON structured like this:

```json
{
  "data": {
    "organizationServices": {
      "bigquery": true,
      "funWithFlags": true,
      "googleCloudStorage": true
    }
  }
}
```

### Return Parameters

| Type                                                                 | Description                                         |
| -------------------------------------------------------------------- | --------------------------------------------------- |
| <a href="#organizationservicesresult">organizationServicesResult</a> | Queried organization or Current user's organization |

## Count all Organizations

```graphql
query countOrganizations($filter: OrganizationFilter) {
  countOrganizations(filter: $filter)
}

{
  "filter": {
    "language": "Hindi"
  }
}
```

> The above query returns JSON structured like this:

```json
{
  "data": {
    "countOrganizations": 2
  }
}
```

### Query Parameters

| Parameter | Type                                                 | Default | Description     |
| --------- | ---------------------------------------------------- | ------- | --------------- |
| filter    | <a href="#organizationfilter">OrganizationFilter</a> | nil     | filter the list |

### Return Parameters

| Type                   | Description                    |
| ---------------------- | ------------------------------ |
| <a href="#int">Int</a> | Count of filtered organization |

## Create an Organization

```graphql
mutation createOrganization($input:OrganizationInput!) {
  createOrganization(input: $input) {
    organization {
      id
      name
      shortcode
      contact {
        id
      }
      email
      bsp {
        id
        name
      }
      defaultLanguage {
        id
        label
      }
    }
    errors {
      key
      message
    }
  }
}

{
  "input": {
    "shortcode": "new_organization",
    "name": "new organization",
    "contactId": 1,
    "email": "test@test.com",
    "bspId": 1,
    "defaultLanguageId": 1,
    "activeLanguageIds": [1]
  }
}
```

> The above query returns JSON structured like this:

```json
{
  "data": {
    "createOrganization": {
      "errors": null,
      "organization": {
        "contact": {
          "id": "1"
        },
        "defaultLanguage": {
          "id": "1",
          "label": "Hindi"
        },
        "name": "new organization",
        "email": "test@test.com",
        "id": "3",
        "shortcode": "new_organization",
        "bsp": {
          "id": "1",
          "name": "Default Provider"
        }
      }
    }
  }
}
```

### Query Parameters

| Parameter | Type                                               | Default  | Description |
| --------- | -------------------------------------------------- | -------- | ----------- |
| input     | <a href="#organizationinput">OrganizationInput</a> | required |             |

### Return Parameters

| Type                                                 | Description                     |
| ---------------------------------------------------- | ------------------------------- |
| <a href="#organizationresult">OrganizationResult</a> | The created organization object |

## Update an Organization

```graphql
mutation updateOrganization($id: ID!, $input: OrganizationInput!) {
  updateOrganization(id: $id, input: $input) {
    organization {
      id
      name
      shortcode
      sessionLimit
      outOfOffice {
        enabled
        startTime
        endTime
        flowId
        enabledDays {
          id
          enabled
        }
      }
    }
    errors {
      key
      message
    }
  }
}

{
  "id": "1",
  "input": {
    "name": "updated organization display name",
    "sessionLimit": 180,
    "outOfOffice": {
      "enabled": true,
      "enabledDays": [
        {
          "enabled": true,
          "id": 1
        },
        {
          "enabled": true,
          "id": 2
        },
        {
          "enabled": true,
          "id": 3
        },
        {
          "enabled": true,
          "id": 4
        },
        {
          "enabled": true,
          "id": 5
        },
        {
          "enabled": false,
          "id": 6
        },
        {
          "enabled": false,
          "id": 7
        }
      ],
      "endTime": "T19:00:00",
      "flowId": 1,
      "defaultFlowId": 1,
      "startTime": "T09:00:00"
    }
  }
}
```

> The above query returns JSON structured like this:

```json
{
  "data": {
    "updateOrganization": {
      "errors": null,
      "organization": {
        "name": "updated organization display name",
        "id": "1",
        "name": "Glific",
        "sessionLimit": 180,
        "outOfOffice": {
          "enabled": true,
          "enabledDays": [
            {
              "enabled": true,
              "id": 1
            },
            {
              "enabled": true,
              "id": 2
            },
            {
              "enabled": true,
              "id": 3
            },
            {
              "enabled": true,
              "id": 4
            },
            {
              "enabled": true,
              "id": 5
            },
            {
              "enabled": false,
              "id": 6
            },
            {
              "enabled": false,
              "id": 7
            }
          ],
          "endTime": "19:00:00",
          "flowId": "1",
          "startTime": "9:00:00"
        }
      }
    }
  }
}
```

Enabled days Ids represets weekdays starting from 1 for Monday.

### Query Parameters

| Parameter | Type                                               | Default  | Description |
| --------- | -------------------------------------------------- | -------- | ----------- |
| id        | <a href="#id">ID</a>!                              | required |             |
| input     | <a href="#organizationinput">OrganizationInput</a> | required |             |

### Return Parameters

| Type                                                 | Description                     |
| ---------------------------------------------------- | ------------------------------- |
| <a href="#organizationresult">OrganizationResult</a> | The updated organization object |

## Delete an Organization

```graphql
mutation deleteOrganization($id: ID!) {
  deleteOrganization(id: $id) {
    errors {
      key
      message
    }
  }
}

{
  "id": "3"
}
```

> The above query returns JSON structured like this:

```json
{
  "data": {
    "deleteOrganization": {
      "errors": null
    }
  }
}
```

In case of errors, all the above functions return an error object like the below

```json
{
  "data": {
    "deleteOrganization": {
      "errors": [
        {
          "key": "Elixir.Glific.Partners.Organization 3",
          "message": "Resource not found"
        }
      ]
    }
  }
}
```

### Query Parameters

| Parameter | Type                  | Default  | Description |
| --------- | --------------------- | -------- | ----------- |
| id        | <a href="#id">ID</a>! | required |             |

### Return Parameters

| Type                                                 | Description              |
| ---------------------------------------------------- | ------------------------ |
| <a href="#organizationresult">OrganizationResult</a> | An error object or empty |

## Check for attachment support for the given user

```graphql
query attachmentsEnabled {
  attachmentsEnabled
}
```

> The above query returns JSON structured like this:

```json
{
  "data": {
    "attachmentsEnabled": true
  }
}
```

### Return Parameters

| Type                           | Description                                              |
| ------------------------------ | -------------------------------------------------------- |
| <a href="#boolean">Boolean</a> | Have we enabled attachment support for this organization |

## Get List of Timezones

```graphql
query timezones {
  timezones
}
```

> The above query returns JSON structured like this:

```json

{
  "data": {
    "timezones": [
      "Africa/Abidjan",
      "Africa/Accra",
      "Africa/Addis_Ababa",
      ...
    ]
  }
}
```

This returns list of timezones

### Return Parameters

| Type                           | Description       |
| ------------------------------ | ----------------- |
| [<a href="#string">String</a>] | List of timezones |

## Get List of Organization Status

```graphql
query organizationStatus {
  organizationStatus
}
```

> The above query returns A list of all the organization status:

```json

{
  "data": {
    "organizationStatus": [
      "INACTIVE",
      "APPROVED",
      "ACTIVE",
      "SUSPENDED",
      "READY_TO_DELETE"
    ]
  }
}
```

This returns list of timezones

### Return Parameters

| Type                           | Description       |
| ------------------------------ | ----------------- |
| [<a href="#string">String</a>] | List of status |

## Subscription for Wallet Balance

```graphql
subscription organization_subscriptions {
  bsp_balance(organizationId: "1")
}
```

> The above query returns JSON structured like this:

```json
{
  "data": {
    "bspbalance": "{\"balance\":0.426}"
  }
}
```

### Return Parameters

| Parameter                                                                                    | Type | Default | Description |
| -------------------------------------------------------------------------------------------- | ---- | ------- | ----------- |
| <a href="#json">JSON with "balance" as name and the amount of remaining balance as value</a> |

## Subscription for Collection Count

```graphql
subscription organization_subscriptions {
  collection_count(organizationId: "1")
}
```

> The above query returns JSON structured like this:

```json
{
  "data": {
    "collection": "{
      \"All\": 5,
      \"Not Responded\": 3,
      \"Not replied\": 2,
      \"Optout\": 0,
      \"Unread\": 4
    }"
  }
}
```

### Return Parameters

| Parameter                                                                                                                    | Type | Default | Description |
| ---------------------------------------------------------------------------------------------------------------------------- | ---- | ------- | ----------- |
| <a href="#json">JSON with "collection" as name and array with key as collection count name and value as collection count</a> |

## Subscription for Simulator release

```graphql
subscription organization_subscriptions {
  simulator_release(organizationId: "1")
}
```

> The above query returns JSON structured like this:

```json
{
  "data": {
    "simulator_release": "{\"simulator_release\":{\"user_id\":1}"
  }
}
```

### Return Parameters

| Parameter                                                                                                       | Type | Default | Description |
| --------------------------------------------------------------------------------------------------------------- | ---- | ------- | ----------- |
| <a href="#json">JSON with "simulator_release" as name and array with key as user_id and value as id of user</a> |

## Organization Objects

### Organization

<table>
<thead>
<tr>
<th align="left">Field</th>
<th align="right">Argument</th>
<th align="left">Type</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="2" valign="top"><strong>contact</strong></td>
<td valign="top"><a href="#contact">Contact</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>defaultLanguage</strong></td>
<td valign="top"><a href="#language">Language</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>activeLanguages</strong></td>
<td valign="top">[<a href="#language">Language</a>]</td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>shortcode</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>email</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>id</strong></td>
<td valign="top"><a href="#id">ID</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>name</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>bsp</strong></td>
<td valign="top"><a href="#provider">Provider</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>outOfOffice</strong></td>
<td valign="top"><a href="#outofoffice">OutOfOffice</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>newcontactFlowId</strong></td>
<td valign="top"><a href="#id">ID</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>isActive</strong></td>
<td valign="top"><a href="#boolean">Boolean</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>timezone</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>sessionLimit</strong></td>
<td valign="top"><a href="#integer">Integer</a></td>
<td>(in minutes)</td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>signaturePhrase</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>insertedAt</strong></td>
<td valign="top"><a href="#datetime">DateTime</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>updatedAt</strong></td>
<td valign="top"><a href="#datetime">DateTime</a></td>
<td></td>
</tr>
</tbody>
</table>

### OrganizationResult

<table>
<thead>
<tr>
<th align="left">Field</th>
<th align="right">Argument</th>
<th align="left">Type</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="2" valign="top"><strong>errors</strong></td>
<td valign="top">[<a href="#inputerror">InputError</a>]</td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>organization</strong></td>
<td valign="top"><a href="#organization">Organization</a></td>
<td></td>
</tr>
</tbody>
</table>

### Organization Services Result

<table>
<thead>
<tr>
<th align="left">Field</th>
<th align="right">Argument</th>
<th align="left">Type</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="2" valign="top"><strong>fun_with_flags</strong></td>
<td valign="top"><a href="#boolean">Boolean</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>dialogflow</strong></td>
<td valign="top"><a href="#boolean">Boolean</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>google_cloud_storage</strong></td>
<td valign="top"><a href="#boolean">Boolean</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>bigquery</strong></td>
<td valign="top"><a href="#boolean">Boolean</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>errors</strong></td>
<td valign="top">[<a href="#inputerror">InputError</a>]</td>
<td></td>
</tr>
</tbody>
</table>

### OutOfOffice

<table>
<thead>
<tr>
<th align="left">Field</th>
<th align="right">Argument</th>
<th align="left">Type</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="2" valign="top"><strong>enabled</strong></td>
<td valign="top"><a href="#boolean">Boolean</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>startTime</strong></td>
<td valign="top"><a href="#time">Time</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>endTime</strong></td>
<td valign="top"><a href="#time">Time</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>enabledDays</strong></td>
<td valign="top">[<a href="#enabledday">EnabledDay</a>]</td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>flow_id</strong></td>
<td valign="top"><a href="#id">ID</a></td>
<td></td>
</tr>
</tbody>
</table>

### EnabledDay

<table>
<thead>
<tr>
<th align="left">Field</th>
<th align="right">Argument</th>
<th align="left">Type</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="2" valign="top"><strong>id</strong></td>
<td valign="top"><a href="#integer">Integer</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>enabled</strong></td>
<td valign="top"><a href="#boolean">Boolean</a></td>
<td></td>
</tr>
</tbody>
</table>

## Organization Inputs

### OrganizationFilter

Filtering options for organizations

<table>
<thead>
<tr>
<th colspan="2" align="left">Field</th>
<th align="left">Type</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="2" valign="top"><strong>defaultLanguage</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td>

Match the default language

</td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>shortcode</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td>

Match the shortcode

</td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>email</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td>

Match the email

</td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>name</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td>

Match the name

</td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>bsp</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td>

Match the bsp provider

</td>
</tr>
</tbody>
</table>

### OrganizationInput

<table>
<thead>
<tr>
<th colspan="2" align="left">Field</th>
<th align="left">Type</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="2" valign="top"><strong>contactId</strong></td>
<td valign="top"><a href="#id">ID</a></td>
<td>

Nullable

</td>
</tr>

<tr>
<td colspan="2" valign="top"><strong>name</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td>

Unique

</td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>defaultLanguageId</strong></td>
<td valign="top"><a href="#id">ID</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>activeLanguageIds</strong></td>
<td valign="top">[<a href="#id">ID</a>]</td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>shortcode</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>email</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>bspId</strong></td>
<td valign="top"><a href="#id">ID</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>outOfOfficeInput</strong></td>
<td valign="top"><a href="#outofofficeinput">OutOfOfficeInput</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>isActive</strong></td>
<td valign="top"><a href="#boolean">Boolean</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>timezone</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>sessionLimit</strong></td>
<td valign="top"><a href="#integer">Integer</a></td>
<td>(in minutes)</td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>signaturePhrase</strong></td>
<td valign="top"><a href="#string">String</a></td>
<td></td>
</tr>
</tbody>
</table>

### OutOfOfficeInput

<table>
<thead>
<tr>
<th align="left">Field</th>
<th align="right">Argument</th>
<th align="left">Type</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="2" valign="top"><strong>enabled</strong></td>
<td valign="top"><a href="#boolean">Boolean</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>startTime</strong></td>
<td valign="top"><a href="#time">Time</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>endTime</strong></td>
<td valign="top"><a href="#time">Time</a></td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>enabledDays</strong></td>
<td valign="top">[<a href="#enableddayinput">EnabledDayInput</a>]</td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>flow_id</strong></td>
<td valign="top"><a href="#id">ID</a></td>
<td></td>
</tr>
</tbody>
</table>

### EnabledDayInput

<table>
<thead>
<tr>
<th align="left">Field</th>
<th align="right">Argument</th>
<th align="left">Type</th>
<th align="left">Description</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="2" valign="top"><strong>id</strong></td>
<td valign="top"><a href="#integer">Integer</a>!</td>
<td></td>
</tr>
<tr>
<td colspan="2" valign="top"><strong>enabled</strong></td>
<td valign="top"><a href="#boolean">Boolean</a>!</td>
<td></td>
</tr>
</tbody>
</table>
