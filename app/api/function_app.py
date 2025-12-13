import azure.functions as func
import json

app = func.FunctionApp(http_auth_level=func.AuthLevel.ANONYMOUS)

@app.function_name(name="hello")
@app.route(route="hello", methods=["GET"])
def hello(req: func.HttpRequest) -> func.HttpResponse:
    return func.HttpResponse(
        json.dumps({"message": "Hello from Azure Function API!"}),
        content_type="application/json",
        status_code=200
    )
