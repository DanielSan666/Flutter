const mongoose = require("mongoose")

const userSchema = mongoose.Schema({
    name: {
        require: true,
        type: String,
        trim: true,
    },
    email:{
        require: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re =
                /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
              return value.match(re);
            },
            message: "Please enter a valid email address",
        },
    },
    password: {
        require: true,
        type: String,
    }
});

const User = mongoose.model("User", userSchema);
module.exports = User;