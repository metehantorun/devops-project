import pytest
from app import app

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_ping_endpoint(client):
    response = client.get('/ping')
    assert response.status_code == 200
    assert response.data.decode('utf-8') == "pong"

def test_healthz_endpoint(client):
    response = client.get('/healthz')
    assert response.status_code == 200
    json_data = response.get_json()
    assert json_data["status"] == "healthy"