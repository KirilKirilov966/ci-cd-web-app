const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Hello, DevOps World!');
});

const PORT = process.env.PORT || 4000;  // Changed from 3000 to 4000
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
