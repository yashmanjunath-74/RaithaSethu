const mongoose = require('mongoose');
const { productSchema } = require('./product');

const FarmerSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        trim: true,
        validate: {
            validator: function(v) {
                return /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/.test(v);
            },
            message: props => `${props.value} is not a valid email!`
        }
    },
    password: {
        type: String,
        required: true,
        validate : {
            validator: function(v) {
                return v.length >= 6;
            },
                message: props => `${props.value} enter long password!`
            }
    },
    address: {
        type: String,
        trim: true,
        required: true,
    },
    phone: {
        type: String,
        required: true,
        validate: {
            validator: function(v) {
                return /^\d{10}$/.test(v);
            },
            message: props => `${props.value} is not a valid phone number!`
        },
        trim: true,
    },
    products: [productSchema],
 
});

const Farmer = mongoose.model('Farmer', FarmerSchema);
module.exports = Farmer;