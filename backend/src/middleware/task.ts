import {Router} from "express";

import {auth} from "./auth";
import {AuthRequest} from "./auth";
import {db} from "../db";
import {NewTask, tasks} from "../db/schema";
import {and, eq} from "drizzle-orm";


const taskRouter = Router();

taskRouter.post('/', auth, async (req: AuthRequest, res) => {

    try {
        req.body = {...req.body,dueAt:new Date(req.body.dueAt) , uid: req.user};

        const newTask: NewTask = req.body;
        const [task] = await db.insert(tasks).values(newTask).returning();
        res.status(201).json(task);
    } catch (e) {


        res.status(500).json({error: e});


    }

})

taskRouter.get('/', auth, async (req: AuthRequest, res) => {

    try {
        const allTask = await db.select().from(tasks).where(eq(tasks.uid, req.user!));

        res.json(allTask);
    } catch (e) {


        res.status(500).json({error: e});


    }

})

taskRouter.delete('/', auth, async (req: AuthRequest, res) => {
    try {
        const {taskId}: { taskId: string } = req.body;

        // First, verify the task exists and belongs to the user
        const [task] = await db
            .select()
            .from(tasks)
            .where(
                and(
                    eq(tasks.id, taskId),
                    eq(tasks.uid, req.user!)
                )
            )
            .limit(1);

        if (!task) {
            return res.status(404).json({error: 'Task not found or access denied'});
        }

        // If we get here, the task exists and belongs to the user
        await db.delete(tasks)
            .where(
                and(
                    eq(tasks.id, taskId),
                    eq(tasks.uid, req.user!)  // Extra safety check
                )
            );
        res.json(true);
    } catch (e) {

        res.status(500).json({error: 'Failed to delete task'});
    }
});
export default taskRouter;