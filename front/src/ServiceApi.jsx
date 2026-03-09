
export default class ServiceApi {
  constructor() {
    this.url = 'http://localhost:3000'
  }

  async loadFolderIndex(fileName) {
    try {
      const response = await fetch(`${this.url}/load/${fileName}`);
      return await response.json();
    } catch (error) {
      return console.error(error);
    }
  }
  
  async getDates() {
    try {
      const response = await fetch(`${this.url}/dates`);
      return await response.json();
    } catch (error) {
      return console.error(error);
    }
  }

  async getTtiMessagesByType() {
    try {
      const response = await fetch(`${this.url}/tti/bytype`);
      return await response.json();
    } catch (error) {
      return console.error(error);
    }
  }

  async getFolders() {
    try {
      const response = await fetch(`${this.url}/folders`);
      return await response.json();
    } catch (error) {
      return console.error('Error fetching files:', error);
    }
  }

  async getDate2s(fileName) {
    try {
      const response = await fetch(`${this.url}/dates/${fileName}`);
      return await response.json();
    } catch (error) {
      return console.error('Error fetching dates:', error);
    }
  }

  async getTtiBy5MinAndCateg(fileName) {
    try {
      const response = await fetch(`${this.url}/tti/by5minandcateg`);
      return await response.json();
    } catch (error) {
      return console.error('Error fetching dates:', error);
    }
  }

  async getOrders(fileName) {
    try {
      const response = await fetch(`${this.url}/tti/orders`);
      return await response.json();
    } catch (error) {
      return console.error('Error fetching dates:', error);
    }
  }

  async getTtiBy5Min(fileName) {
    try {
      const response = await fetch(`${this.url}/tti/by5min`);
      return await response.json();
    } catch (error) {
      return console.error('Error fetching dates:', error);
    }
  }

  async loadFileAndDate(fileName, date) {
    try {
      const response = await fetch(`${this.url}/files/${fileName}/${date}`);
      return await response.json();
    } catch (error) {
      return console.error('Error fetching dates:', error);
    }
  }

 async getGwpackTimeSpent(date) {
    console.log(`Calling getGwpackTimeSpent with parameter: ${date}`)
    try {
      const response = await fetch(`${this.url}/xmluuid/${date}`);
      return await response.json();
    } catch (error) {
      return console.error('Error fetching dates:', error);
    }
  }
}