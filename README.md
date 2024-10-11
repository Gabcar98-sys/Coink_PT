Prueba tecnica para Coink. 


Se agregan valores para las ciudades y departamentos. No fue posible sacar un backup de la base así que dejaré los archivos de la base de datos para cada tabla. 

Modelo entidad relación.

![Coink drawio](https://github.com/user-attachments/assets/7e7ca26a-d17f-4c40-bdc7-cd19f02efd1c)


Add openApi
{
  "openapi": "3.0.1",
  "info": {
    "title": "Coink",
    "version": "1.0"
  },
  "paths": {
    "/api/City/{state_id}": {
      "get": {
        "tags": [
          "City"
        ],
        "parameters": [
          {
            "name": "state_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/City": {
      "post": {
        "tags": [
          "City"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/CityModel"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/CityModel"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/CityModel"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/Client": {
      "get": {
        "tags": [
          "Client"
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      },
      "post": {
        "tags": [
          "Client"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/ClientModel"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/ClientModel"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/ClientModel"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/Client/{id}": {
      "get": {
        "tags": [
          "Client"
        ],
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/State/{country_id}": {
      "get": {
        "tags": [
          "State"
        ],
        "parameters": [
          {
            "name": "country_id",
            "in": "path",
            "required": true,
            "schema": {
              "type": "integer",
              "format": "int32"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    },
    "/api/State": {
      "post": {
        "tags": [
          "State"
        ],
        "requestBody": {
          "content": {
            "application/json": {
              "schema": {
                "$ref": "#/components/schemas/StateModel"
              }
            },
            "text/json": {
              "schema": {
                "$ref": "#/components/schemas/StateModel"
              }
            },
            "application/*+json": {
              "schema": {
                "$ref": "#/components/schemas/StateModel"
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "OK"
          }
        }
      }
    }
  },
  "components": {
    "schemas": {
      "CityModel": {
        "required": [
          "cityName",
          "stateId"
        ],
        "type": "object",
        "properties": {
          "cityName": {
            "type": "string",
            "nullable": true
          },
          "stateId": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "ClientModel": {
        "required": [
          "address",
          "firstName",
          "lastName"
        ],
        "type": "object",
        "properties": {
          "firstName": {
            "type": "string",
            "nullable": true
          },
          "lastName": {
            "type": "string",
            "nullable": true
          },
          "address": {
            "type": "string",
            "nullable": true
          },
          "phoneNumber": {
            "type": "integer",
            "format": "int64"
          },
          "city_id": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      },
      "StateModel": {
        "required": [
          "countryId",
          "stateName"
        ],
        "type": "object",
        "properties": {
          "stateName": {
            "type": "string",
            "nullable": true
          },
          "countryId": {
            "type": "integer",
            "format": "int32"
          }
        },
        "additionalProperties": false
      }
    }
  }
}
