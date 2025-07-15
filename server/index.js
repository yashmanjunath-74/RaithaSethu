//IMPORTING SERVER DEPENDENCIES
const express = require('express');
const mongoose = require('mongoose');

//IMPORTING FROM OTHER FILES
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productSchema = require('./models/product');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

// INIT
const PORT =  3001;
const app = express();
const DB = "mongodb+srv://yashyashwanth7447:yash2005@cluster0.cvmbvtn.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// MIDDELWARESrs
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// Middleware to log incoming requests
app.use((req, res, next) => {
    console.log(`Incoming request: ${req.method} ${req.url}`);
    next();
});

app.get('/yash', (req, res) => {    
    res.send('Hello World!');
});

// Function to connect to the database
const connectToDatabase = async () => {
    try {
        await mongoose.connect(DB);
        console.log('Connected to the database');
    } catch (err) {
        console.error('Database connection failed:', err);
        process.exit(1); // Exit process with failure
    }
};

// Function to start the server
const startServer = () => {
    app.listen(PORT, "0.0.0.0", () => {
        console.log(`Server is running on port ${PORT}`);
        console.log(`Accessible at http://10.0.2.2:${PORT}/yash`);
    });
};

// Initialize the application
const initializeApp = async () => {
    await connectToDatabase();
    startServer();
};

initializeApp();