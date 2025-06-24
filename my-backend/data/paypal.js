// paypal.js
const axios = require('axios');

const PAYPAL_CLIENT = 'AZEHkGuS6nzY-sEkUrPoZVchSozFQuwbqiLD2o7Ym0VXdz-szKko2GDGfYh0695eKCL3wH2OUDnMg7qq';
const PAYPAL_SECRET = 'EF88Q3WCKU2KsfVQHQRl6dFNy-yZa_ObcvNZHJPSztAb-eGg7II0geNuhSJVbc1NTC5742goQOa51IDq';

async function createPaypalOrder(amount) {
    const auth = Buffer.from(`${PAYPAL_CLIENT}:${PAYPAL_SECRET}`).toString('base64');

    // Get Access Token
    const tokenRes = await axios.post(
        'https://api-m.sandbox.paypal.com/v1/oauth2/token',
        'grant_type=client_credentials',
        {
            headers: {
                Authorization: `Basic ${auth}`,
                'Content-Type': 'application/x-www-form-urlencoded',
            },
        }
    );

    const accessToken = tokenRes.data.access_token;

    // Create Order
    const orderRes = await axios.post(
        'https://api-m.sandbox.paypal.com/v2/checkout/orders',
        {
            intent: 'CAPTURE',
            purchase_units: [{
                amount: {
                    currency_code: 'USD',
                    value: amount
                }
            }],
            application_context: {
                return_url: 'https://example.com/success',
                cancel_url: 'https://example.com/cancel'
            }
        },
        {
            headers: {
                Authorization: `Bearer ${accessToken}`,
                'Content-Type': 'application/json',
            },
        }
    );

    return orderRes.data;
}

module.exports = { createPaypalOrder };
