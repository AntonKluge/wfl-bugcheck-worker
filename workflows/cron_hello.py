from pydantic import BaseModel
import mistralai.workflows as workflows
from mistralai.workflows.models import ScheduleDefinition


class CronHelloInput(BaseModel):
    name: str


class CronHelloOutput(BaseModel):
    greeting: str


schedule = ScheduleDefinition(
    input={"name": "cron"},
    cron_expressions=["*/10 * * * *"],
)


@workflows.workflow.define(name="cron_hello", schedules=[schedule])
class CronHelloWorkflow:
    @workflows.activity
    async def greet(self, name: str) -> str:
        return f"Hello, {name}!"

    @workflows.workflow.entrypoint
    async def run(self, input: CronHelloInput) -> CronHelloOutput:
        greeting = await self.greet(name=input.name)
        return CronHelloOutput(greeting=greeting)
