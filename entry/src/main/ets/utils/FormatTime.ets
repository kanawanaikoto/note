interface TimeFormat {
  range: string
  formatDate: string
  formatTime: string
}

// 时间格式化
export default function getFormatTime(time: number): TimeFormat {
  const date = new Date(time)
  const today = new Date()
  const diff = today.getTime() - date.getTime()
  const diffDay = Math.floor(diff / (24 * 60 * 60 * 1000))
  let range: string
  if (diffDay === 0) {
    range = "今天"
  } else if (diffDay === 1) {
    range = "昨天"
  } else if (diffDay > 1 && diffDay <= 7) {
    range = "本周"
  } else {
    range = date.toLocaleDateString()
  }
  const month: string = (date.getMonth() + 1).toString().padStart(2, '0')
  const day: string = date.getDate().toString().padStart(2, '0')
  const hour: string = date.getHours().toString().padStart(2, '0')
  const minute: string = date.getMinutes().toString().padStart(2, '0')

  const formatDate: string = `${month}月${day}日`
  const formatTime: string = `${hour}:${minute}`

  return {
    range: range,
    formatDate: formatDate,
    formatTime: formatTime
  }
}