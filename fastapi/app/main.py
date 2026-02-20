from fastapi import FastAPI

app = FastAPI(title="Data Bot API", version="1.0.0")


@app.get("/")
async def root():
    return {"message": "Data Bot API is running"}


@app.get("/health")
async def health():
    return {"status": "healthy"}
