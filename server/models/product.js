const mongoose = require('mongoose');
const ratingSchema = require('./rating');

const productSchema = new mongoose.Schema({
    productName: {
        type: String,
        required: true,
        trim: true,
    },
    price: {
        type: Number,
        required: true,
    },
    quantity: {
        type: Number,
        required: true,
    },
    description: {
        type: String,
        required: true,
        trim: true,
    },
    category: {
        type: String,
        required: true,
        trim: true,
    },
    images: [
        {
            type: String,
            required: true,
        },
    ],
    rating: [ratingSchema],
    farmerId: {
        type: String,
        required: true,
        trim: true,
    },
    expectedHarvestDate: {
        type: Date,
        default: null,
    },
});

const Product = mongoose.model('Product', productSchema);
module.exports = { Product, productSchema };