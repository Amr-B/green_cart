const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { readUsers, writeUsers } = require('./users');
const { addProfile } = require('./profiles');
const { readProfiles } = require('./profiles');



// Fake DB for example (replace with real DB like MySQL or SQLite)
const users = [];

// Secret key for JWT
const JWT_SECRET = "es4332auth4w1localhost3000loginregisterapi";

// Register
router.post('/register', async (req, res) => {
    const { name, email, password } = req.body;

    const users = readUsers(); // اقرأ المستخدمين من الملف

    const exists = users.find(user => user.email === email);
    if (exists) return res.status(400).json({ error: "User already exists" });

    const hashedPassword = await bcrypt.hash(password, 10);
    const userId = users.length + 700;

    const newUser = { id: userId, name, email, password: hashedPassword };
    users.push(newUser);
    writeUsers(users); // خزّن المستخدم الجديد

    addProfile({
        id: userId,
        name,
        email,
        image: ''
    });

    res.json({ message: "User registered and profile saved" });
});



router.get('/profiles', (req, res) => {
    try {
        const profiles = readProfiles();
        res.json(profiles);
    } catch (err) {
        res.status(500).json({ error: 'Failed to read profiles' });
    }
});


router.get('/profiles/:id', (req, res) => {
    try {
        const id = parseInt(req.params.id);
        const profiles = readProfiles();
        const profile = profiles.find(p => p.id === id);

        if (!profile) {
            return res.status(404).json({ error: 'Profile not found' });
        }

        res.json(profile);
    } catch (err) {
        res.status(500).json({ error: 'Failed to read profile' });
    }
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
