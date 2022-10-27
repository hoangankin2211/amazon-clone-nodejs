const express = require('express');
const {Product} = require('../models/product');
const User = require('../models/user');
const userRouter = express.Router();
const authMiddleWare = require('../middleware/authMiddleWare');

userRouter.get('/api/user/get-cart',authMiddleWare,async (req,res)=>{
    const id = req.usee;
    const user = User.findById(id);

    if (!user){
        res.status(400).json({msg:'Can not find user authentication'});
    }

    res.json(user.cart);
});

userRouter.post('/api/user/add-to-cart',authMiddleWare,async (req,res)=>{
    const {idProduct} = req.body;

    const product = await Product.findById(idProduct);
    let user = await User.findById(req.user);

    if (!user){
        console.log("!user");
        res.status(400).json({msg:'Can not find user authentication'})
    }

    if (!product) {
        console.log("!product");
        res.status(400).json({msg:'Can not find corresponding product !!!'})
    }

    // if (user.cart == null){
    //     user.cart = [];
    // }

    let responseQuantity = 0;

    if (user.cart.length == 0){
        user.cart.push({product,quantity : 1});
        responseQuantity = 1;
    }else{
        let isExistedProductInCart = false; 
        for (let i=0 ; i<user.cart.length;i++){
            if (user.cart[i].product._id == idProduct){
                user.cart[i].quantity += 1;
                responseQuantity = user.cart[i].quantity;
                isExistedProductInCart = true;
                break;
            }
        }
        if (isExistedProductInCart == false){
            user.cart.push({product,quantity:1});
            responseQuantity = 1;
        }
    }

    user = await user.save();

    res.json({product:product,quantity : responseQuantity});
    
});

module.exports = userRouter;