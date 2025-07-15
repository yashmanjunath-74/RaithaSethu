const jwt = require('jsonwebtoken');
const Farmer = require('../models/farmer');

const FarmerAuth = async (req, res, next) => {
    try {
        const token = req.header('x-farmer-auth-token');
        if (!token)
            return res.status(401).json({ message: "No auth token, access denied" });

        const verified = jwt.verify(token, "passwordKey");
        if (!verified)
            return res.status(401).json({ message: "Token verification failed, access denied" });

        const farmer = await Farmer.findOne({ _id: verified.id, token: token });
        if (!farmer)
            return res.status(401).json({ message: "Farmer not found, access denied" });

        req.farmer = farmer;
        req.token = token;
        next();
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
};

module.exports = FarmerAuth;