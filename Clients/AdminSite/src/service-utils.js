export const showModal = (message) => {
    const modal = document.querySelector('.modal')
    modal.style.display = 'flex'
    document.querySelector('.modal-title').innerHTML = message
    modal.style.opacity = 1
    setTimeout(() => {
        modal.style.opacity = 0
    }, 1200)
}