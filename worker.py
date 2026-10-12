import asyncio

from dotenv import load_dotenv

load_dotenv(override=True)

import mistralai.workflows as workflows

from workflows.hello_world import HelloWorldWorkflow
from workflows.cron_hello import CronHelloWorkflow


def main() -> None:
    asyncio.run(
        workflows.run_worker(
            [
                HelloWorldWorkflow,
                CronHelloWorkflow,
            ]
        )
    )


if __name__ == "__main__":
    main()
