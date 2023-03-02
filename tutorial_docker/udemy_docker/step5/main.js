const tasksTableBodyElement = document.getElementById('tasks-table-body')

async function loadTasks() {
  const response = await fetch('/api/tasks')
  const responseBody = await response.json()

  const tasks = responseBody.tasks

  tasks.forEach((task) => {
    const titleTdElement = document.createElement('td')
    titleTdElement.innerText = task.title

    const createdAtTdElement = document.createElement('td')
    createdAtTdElement.innerText = task.createdAt

    const trElement = document.createElement('tr')
    trElement.appendChild(titleTdElement)
    trElement.appendChild(createdAtTdElement)

    tasksTableBodyElement.appendChild(trElement)
  })
}

async function main() {
  await loadTasks()
}

main()
