const express = require('express');
const User = require('../models/user');
const Farmer = require('../models/farmer'); // Add at the top with other requires
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const Auth = require('../middlewares/auth');

const authRouter = express.Router();

authRouter.post('/api/user/signup',  async (req, res) => {
    //get the data from the client
  try{
    const {name, email, password} = req.body;

    const existinguser =  await User.findOne({ email });
    if(existinguser){
        return res.status(400).json({message: 'User  with same email already exists'});

    }

    const hashpasward = await  bcryptjs.hash(password, 10); 

    let  user = new  User({
        name,
        email,
        password : hashpasward,
    })

    user = await user.save(); 
    res.status(201).json(user);
  }
  catch(e){
    res.status(500).json({ error : e.message});
  }
});

authRouter.post('/api/user/login', async (req,res)=> {
  try{
    const {email, password } = req.body;
    
    const user = await User.findOne({email});
    if(!user){
      return res.status(400).json({message : "User with this email does not exist!"});
    }
    const isMtch = await bcryptjs.compare(password, user.password);

    if (!isMtch){
      return res.status(400).json({message : "Incorect pasward!"});
    }

    const token =jwt.sign({id: user._id},"passwordKey");
    res.json({token, ...user._doc});

  }catch(e){
     res.status(500).json({error:e.message});
  }
});

//Verify The token 
authRouter.post('/tokenIsValid', async(req,res)=>{
 try{
   const token = req.header("x-auth-token");
   if(!token) return res.json(false);

  const Verify = jwt.verify(token,"passwordKey");
  if(!Verify) return res.json(false);

  const user = await User.findById(Verify.id);
  if(!user) return res.json(false);

  res.json(true);
 }catch(e){
  res.status(500).json({error:e.message});
}
});


// get user Data
authRouter.get('/',Auth ,async(req,res) =>{
  const user = await User.findById(req.user);
  res.json({...user._doc,token:req.token});
});

// Farmer Sign Up
authRouter.post('/api/farmer/signup', async (req, res) => {
  try {
    const { name, email, phone, password, address } = req.body;

    const existingFarmer = await Farmer.findOne({ email });
    if (existingFarmer) {
      return res.status(400).json({ message: 'Farmer with same email already exists' });
    }

    const hashPassword = await bcryptjs.hash(password, 10);

    let farmer = new Farmer({
      name,
      email,
      phone,
      password: hashPassword,
      address,
    });

    farmer = await farmer.save();
    res.status(201).json(farmer);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Farmer Login
authRouter.post('/api/farmer/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const farmer = await Farmer.findOne({ email });
    if (!farmer) {
      return res.status(400).json({ message: "Invalid credentials" });
    }
    const isMtch = await bcryptjs.compare(password, farmer.password);

    if (!isMtch){
      return res.status(400).json({message : "Incorect pasward!"});
    }
    const token = jwt.sign({ id: farmer._id }, "passwordKey");
     farmer.token = token;
    await farmer.save();
    res.json({ token, ...farmer._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Farmer Token Validation
authRouter.post('/api/farmer/tokenIsValid', async (req, res) => {
  try {
    const token = req.header("x-farmer-auth-token");
    if (!token) return res.json(false);

    const Verify = jwt.verify(token, "passwordKey");
    if (!Verify) return res.json(false);

    const farmer = await Farmer.findById(Verify.id);
    if (!farmer) return res.json(false);

    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// Get Farmer Data
authRouter.get('/farmer', async (req, res) => {
  try {
    const token = req.header("x-farmer-auth-token");
    if (!token) return res.status(401).json({ message: "No token, authorization denied" });

    const Verify = jwt.verify(token, "passwordKey");
    if (!Verify) return res.status(401).json({ message: "Token is not valid" });

    const farmer = await Farmer.findById(Verify.id);
    if (!farmer) return res.status(404).json({ message: "Farmer not found" });

    res.json({ ...farmer._doc, token });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});



module.exports = authRouter;