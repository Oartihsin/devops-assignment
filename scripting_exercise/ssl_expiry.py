from datetime import datetime
import OpenSSL
import ssl
import requests


# def read_domains(file):
#     with open


slack_channel = '#ssl_expiry_notificatoin'
slack_webhook_url = 'https://hooks.slack.com/services/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'


HOSTS = ['www.google.com', 'www.titan.email','www.gorattle.com']

def send_slack_message(webhook_url, channel, text):
    payload = {
        "channel": channel,
        "text": text,
    }

    try:
        response = requests.post(webhook_url, json=payload)
        response.raise_for_status()
        print("Slack message sent successfully")
    except requests.exceptions.RequestException as e:
        print("Error sending Slack message: {e}")

def check_ssl_expiry(domain, port):
    cert=ssl.get_server_certificate((domain, port))
    x509 = OpenSSL.crypto.load_certificate(OpenSSL.crypto.FILETYPE_PEM, cert)
    bytes=x509.get_notAfter()
    timestamp = bytes.decode('utf-8')


    expiry_date = datetime.strptime(timestamp, '%Y%m%d%H%M%S%z').date()
    now_date = datetime.now().date()


    days_until_expiry = (expiry_date - now_date).days
    return days_until_expiry

if __name__ == '__main__':
    for host in HOSTS:
        domain_expiry_days = check_ssl_expiry(host,443)

        if domain_expiry_days<15:
            message = "The SSL certificate for {0} will expire in {1} days.".format(host,domain_expiry_days)
            send_slack_message(slack_webhook_url, slack_channel, message)
        else:
            message = "The SSL certificate for {0} will NOT expire in {1} days.".format(host,domain_expiry_days)
            send_slack_message(slack_webhook_url, slack_channel, message)



