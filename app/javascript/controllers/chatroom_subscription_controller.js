import { Controller } from "stimulus";
import consumer from "../channels/consumer";

export default class extends Controller {
  static values = { chatroomId: Number, currentUserId: Number }
  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => {
        const wrapper = document.createElement('div');
        wrapper.innerHTML = data
        const message = wrapper.firstElementChild
        const senderId = parseInt(message.dataset.senderId)
        const currentUserId = parseInt(this.currentUserIdValue)
        if (senderId !== currentUserId) {
          this.toIncoming(message)
          console.log("yh")
        }

        const formattedMessage = senderId !== currentUserId
          ? this.replaceAvatar(message)
          : message

        this.element.insertAdjacentElement("beforeend", formattedMessage);
        }
      }
    )

    console.log(`Subscribed to the chatroom with the id ${this.chatroomIdValue}.`)

  }

  disconnect () {
  console.log("Unsubscribed from the chatroom")
  this.channel.unsubscribe()
  }

  replaceAvatar(message) {
    const avatar = message.lastElementChild
    const removedAvatar = message.removeChild(avatar)
    message.prepend(removedAvatar)
    return message
  }

  toIncoming(message) {
    message.classList.remove("user-message")
    message.classList.add("o-user-message")
  }
}
