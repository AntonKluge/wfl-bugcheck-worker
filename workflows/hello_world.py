from pydantic import BaseModel
import mistralai.workflows as workflows


class HelloWorldInput(BaseModel):
    name: str


class HelloWorldOutput(BaseModel):
    greeting: str


@workflows.workflow.define(name="hello_world")
class HelloWorldWorkflow:
    @workflows.workflow.entrypoint
    async def run(self, input: HelloWorldInput) -> HelloWorldOutput:
        greeting = f"Hello, {input.name}!"
        return HelloWorldOutput(greeting=greeting)
