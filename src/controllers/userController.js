const User = require('../models/userModel');

exports.getAllUsers = async (req, res)=>{
    const users = await User.findAll();
    return res.json(users)
}

exports.getUserById = async (req, res)=>{
    const {id} = req.params;
    const user = await User.findByPk(id);

    if(!user){
        return res.status(404).json({error: "Usuário não encontrado"})
    }

    return res.json(user)
}


exports.createUser = async (req, res)=>{
    try{
        const user = await User.create(req.body)
        return res.status(201).json({message: "Usuário cadastrado com sucesso!", user:user});
    }catch(error){
        return res.status(400).json({error: error.message})
    }
    
}

exports.updateUser = async (req, res)=>{
    const {id} = req.params;
    const user = await User.findByPk(id);

    if(!user)return res.status(404).json({message: "Usuário não encontrado."});

    try{
        await user.update(req.body);
        return res.json(user);
    }catch(error){
        return res.json({error: error.message});
    }
}

exports.deleteUser = async (req, res)=>{
    const {id} = req.params;
    const user = await User.findByPk(id);

    if(!user)return res.status(404).json({message: "Usuário não encontrado."});

    try{
        await user.destroy();
        return res.json({message: "Usuário excluído com sucesso!"});
    }catch(error){
        return res.json({error: error.message});
    }
}