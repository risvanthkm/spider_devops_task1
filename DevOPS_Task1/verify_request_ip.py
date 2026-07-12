from fastapi import FastAPI, Request

app = FastAPI()

@app.get("/api")
async def api(request: Request):
    print("Client:", request.client.host)
    print("X-Real-IP:", request.headers.get("X-Real-IP"))
    print("X-Forwarded-For:", request.headers.get("X-Forwarded-For"))

    return {"ok": True}