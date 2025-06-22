const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const groceries = require('./data/groceries');
const vegetables = require('./data/vegetables');
const fruits = require('./data/fruits');
const dairy = require('./data/dairy');



const app = express();
app.use(cors());
app.use(bodyParser.json());

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


// POST إضافة منتج جديد
app.post('/groceries', (req, res) => {
    const grocery = req.body;
    grocery.id = groceries.length + 1;
    groceries.push(grocery);
    res.status(201).json(grocery);
});

app.listen(3000, () => {
    console.log('🚀 Server running on http://localhost:3000');
});
