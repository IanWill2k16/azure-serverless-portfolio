import azure.functions as func
from azure.data.tables import TableServiceClient
from azure.identity import DefaultAzureCredential
from azure.core.credentials import AzureNamedKeyCredential
from azure.core.exceptions import ResourceNotFoundError
import json
import os

app = func.FunctionApp(http_auth_level=func.AuthLevel.ANONYMOUS)

@app.function_name(name="hello")
@app.route(route="hello", methods=["GET"])
def hello(req: func.HttpRequest) -> func.HttpResponse:
    return func.HttpResponse(
        json.dumps({"message": "Hello from Azure Function API!"}),
        mimetype="application/json",
        status_code=200
    )

@app.function_name(name="visit")
@app.route(route="visit", methods=["GET"])
def visit(req: func.HttpRequest) -> func.HttpResponse:
    count = increment_counter()
    return func.HttpResponse(
        json.dumps({"count": count}),
        mimetype="application/json"
    )

def get_table_client():
    account = os.environ["COSMOS_ACCOUNT_NAME"]
    table = os.environ["COSMOS_TABLE_NAME"]

    endpoint = f"https://{account}.table.cosmos.azure.com"
    credential = AzureNamedKeyCredential(account, key)
    
    service = TableServiceClient(endpoint=endpoint, credential=credential)
    return service.get_table_client(table)

def increment_counter():
    table = get_table_client()

    pk = "visits"
    rk = "global"

    try:
        entity = table.get_entity(pk, rk)
        entity["count"] += 1
        table.update_entity(entity)
    except ResourceNotFoundError:
        entity = {
            "PartitionKey": pk,
            "RowKey": rk,
            "count": 1
        }
        table.create_entity(entity)

    return entity["count"]
