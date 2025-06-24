const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { readUsers, writeUsers } = require('./users');

// Fake DB for example (replace with real DB like MySQL or SQLite)
const users = [];

// Secret key for JWT
const JWT_SECRET = "es4332auth4w1localhost3000loginregisterapi";

// Register
router.post('/register', async (req, res) => {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
        return res.status(400).json({ error: "All fields are required" });
    }

    const users = readUsers();

    const exists = users.find(user => user.email === email);
    if (exists) return res.status(400).json({ error: "User already exists" });

    const hashedPassword = await bcrypt.hash(password, 10);
    users.push({ name, email, password: hashedPassword });

    writeUsers(users);

    res.json({ message: "User registered successfully" });
});

// Get all users (for testing/debugging)
router.get('/users', (req, res) => {
    const users = readUsers();

    // علشان ماتعرضش الباسوردات
    const safeUsers = users.map(({ name, email }) => ({ name, email }));

    res.json(safeUsers);
});



// Login
router.post('/login', async (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ error: "Email and password are required" });
    }

    const users = readUsers();

    const user = users.find(user => user.email === email);
    if (!user) return res.status(401).json({ error: "Invalid credentials" });

    const valid = await bcrypt.compare(password, user.password);
    if (!valid) return res.status(401).json({ error: "Invalid credentials" });

    const token = jwt.sign({ email: user.email, name: user.name }, JWT_SECRET, {
        expiresIn: '1h',
    });

    res.json({ token });
});


module.exports = router;
