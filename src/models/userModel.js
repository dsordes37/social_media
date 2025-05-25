const { Sequelize, DataTypes, Model } = require("sequelize")
const sequelize = require("../config/database")

User = sequelize.define(
    "User",
    {
        id:{
            type: DataTypes.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },email:{
            type: DataTypes.STRING,
            allowNull: false,
            unique: true
        },password:{
            type: DataTypes.STRING,
            allowNull: false
        },username:{
            type: DataTypes.STRING,
            allowNull: false,
            unique: true
        },full_name:{
            type: DataTypes.STRING,
            allowNull: false
        },image:{
            type: DataTypes.STRING,
            allowNull: false,
            defaultValue: "https://cdn-icons-png.freepik.com/512/64/64572.png"
        },created_at:{
            type: DataTypes.DATE,
            defaultValue: Sequelize.literal("CURRENT_TIMESTAMP")
        },updated_at:{
            type: DataTypes.DATE,
            defaultValue: Sequelize.literal("CURRENT_TIMESTAMP"),
            onUpdate: Sequelize.literal("CURRENT_TIMESTAMP")
        }
    },{
        tableName: 'users',
        timestamps:true,
        createdAt: "created_at",
        updatedAt: "updated_at"
    }
    
)


module.exports=User

// continuar daqui
