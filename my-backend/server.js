const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const groceries = require('./data/groceries');
const vegetables = require('./data/vegetables');
const fruits = require('./data/fruits');
const dairy = require('./data/dairy');
const meat = require('./data/meat');
const profile = require('./data/profile');
const { createPaypalOrder } = require('./data/paypal');
const authRoutes = require('./auth/auth');
const { readUsers, writeUsers } = require('./auth/users');




const app = express();
app.use(cors());
app.use(bodyParser.json());
const PORT = 3000;

app.listen(3000, () => {
    console.log('🚀 Server running on http://localhost:3000');
});


// > auth
app.use('/', authRoutes);



app.post('/create-paypal-order', async (req, res) => {
    try {
        const { amount } = req.body;
        const order = await createPaypalOrder(amount);
        res.json(order);
    } catch (err) {
        console.error(err.message);
        res.status(500).json({ error: 'Failed to create PayPal order' });
    }
});


// GET All groceries
app.get('/groceries', (req, res) => {
    res.json(groceries);
});

// GET single grocery by ID
app.get('/groceries/:id', (req, res) => {
    const id = parseInt(req.params.id);
    const item = groceries.find(g => g.id === id);

    if (item) {
        res.json(item);
    } else {
        res.status(404).json({ error: 'Item not found' });
    }
});

// > get all vegetables 
app.get('/vegetables', (req, res) => {
    res.json(vegetables);
});

// GET single vegetable by ID
app.get('/vegetables/:id', (req, res) => {
    const id = parseInt(req.params.id);
    const item = vegetables.find(v => v.id === id);

    if (item) {
        res.json(item);
    } else {
        res.status(404).json({ error: 'Item not found' });
    }
});




// GET single fruit by ID
app.get('/fruits/:id', (req, res) => {
    const id = parseInt(req.params.id);
    const item = fruits.find(v => v.id === id);

    if (item) {
        res.json(item);
    } else {
        res.status(404).json({ error: 'Item not found' });
    }
});


// > get all fruits 
app.get('/fruits', (req, res) => {
    res.json(fruits);
});



// > get all dairy 
app.get('/dairy', (req, res) => {
    res.json(dairy);
});

// GET single fruit by ID
app.get('/dairy/:id', (req, res) => {
    const id = parseInt(req.params.id);
    const item = dairy.find(v => v.id === id);

    if (item) {
        res.json(item);
    } else {
        res.status(404).json({ error: 'Item not found' });
    }
});


// > get all Meat 
app.get('/meat', (req, res) => {
    res.json(meat);
});

// GET single Meat by ID
app.get('/meat/:id', (req, res) => {
    const id = parseInt(req.params.id);
    const item = meat.find(v => v.id === id);

    if (item) {
        res.json(item);
    } else {
        res.status(404).json({ error: 'Item not found' });
    }
});


// > get user profile info
app.get('/profile', (req, res) => {
    res.json(profile);
});

app.get('/profile/:id', (req, res) => {
    const id = parseInt(req.params.id);
    const item = profile.find(v => v.id === id);

    if (item) {
        res.json(item);
    } else {
        res.status(404).json({ error: 'Item not found' });
    }
});



// POST إضافة منتج جديد
app.post('/groceries', (req, res) => {
    const grocery = req.body;
    grocery.id = groceries.length + 1;
    groceries.push(grocery);
    res.status(201).json(grocery);
});

