import {Router, Request, Response} from "express";
import {db} from "../db";
import {NewUser, users} from "../db/schema";
import {eq} from "drizzle-orm";
import bcryptjs from "bcryptjs";
import jwt from "jsonwebtoken";
import dotenv from "dotenv"


dotenv.config()

const authRouter = Router();

interface SignUpBody {
    name: string,
    email: string,
    password: string
}

interface LoginBody {

    email: string,
    password: string
}


authRouter.post("/signup", async (req: Request<{}, {}, SignUpBody>, res: Response) => {
    try {
        //get req body
        const {name, email, password} = req.body;

        //check if user already exist
        const existingUser = await db.select().from(users).where(eq(users.email, email));
        if (existingUser.length) {
            res.status(400).json({
                msg: "User already Exists"
            })
            return;
        }

        // hashed password
        const hashedPassword = await bcryptjs.hash(password, 8);

        //create a new user
        const newUser: NewUser = {
            name: name,
            email: email,
            password: hashedPassword,
        }

        const [user] = await db.insert(users).values(newUser).returning();
        res.status(201).json(user);


    } catch (e) {
        res.status(500).json({error: e})
    }
})


authRouter.post("/login", async (req: Request<{}, {}, LoginBody>, res: Response) => {
    try {
        //get req body
        const {email, password} = req.body;

        //check if user does not exist
        const [existingUser] = await db.select().from(users).where(eq(users.email, email));
        if (!existingUser) {
            res.status(400).json({
                msg: "User with this email does not  Exists"
            })
            return;
        }

        // isMatched password
        const isMatch = await bcryptjs.compare(password, existingUser.password);


        if (!isMatch) {
            res.status(400).json({msg: "Incorrect password"})
            return;
        }
        const token = jwt.sign({id: existingUser.id}, process.env.JWT_KEY!);
        res.json({token, ...existingUser});


    } catch (e) {
        res.status(500).json({error: e})
    }
})
authRouter.post('/tokenIsValid', async (req, res) => {
    try {
        //get header
        const token = req.header("x-auth-token");
        if (!token) {
            res.json(false);
            return;
        }
        // verify the token is valid
        const verified = jwt.verify(token!, process.env.JWT_KEY!)

        if (!verified) {
            res.json(false);
            return;
        }
        // get user data if the token is valid

        const verifiedToken = verified as { id: string };

        const [user] = await db.select().from(users).where(eq(users.id, verifiedToken.id));

        if (!user) {
            res.json(false);
            return;
        }

        res.json(true);
    } catch (e) {
        res.status(500).json(false)
    }
});

authRouter.get('/', (req, res) => {
    res.send("hey there auth router");
})

export default authRouter;

