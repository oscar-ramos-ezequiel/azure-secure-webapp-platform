from flask import Flask

app = Flask(__name__)


@app.route("/")
def home():
    return """
    <html>
        <head>
            <title>Azure Cloud Portfolio</title>
        </head>
        <body>
            <h1>Azure Secure Web App Platform</h1>

            <p>Python application running on Microsoft Azure App Service.</p>

            <h2>Technologies</h2>
            <ul>
                <li>Microsoft Azure</li>
                <li>Azure App Service</li>
                <li>Linux</li>
                <li>Python / Flask</li>
                <li>GitHub</li>
                <li>CI/CD - coming next</li>
                <li>Terraform - coming next</li>
            </ul>

            <p>Environment: Development</p>
        </body>
    </html>
    """


@app.route("/health")
def health():
    return {
        "status": "healthy",
        "service": "azure-secure-webapp-platform"
    }


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
