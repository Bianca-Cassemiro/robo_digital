import "./App.css";
import toast, { Toaster } from "react-hot-toast";
import { useState } from "react";

const notify = () => toast.success("Suas posições foram enviadas");
const App = () => {
  const [x, setX] = useState("");
  const [y, setY] = useState("");
  const [z, setZ] = useState("");
  const [rX, setrX] = useState("");
  const [rY, setrY] = useState("");
  const [rZ, setrZ] = useState("");


  return (
    <div className="App">
      <Toaster position="bottom-right" reverseOrder={true} />
      <h1>Controle do robô digital</h1>
      <form method="post" action="/create" >
        <label>Coloque a posição X:</label>
        <input
          className="input"
          name = "x"
          value = {x}
          onChange={(e) => setX(e.target.value)}
        />
        <label>Coloque a posição Y:</label>
        <input
          className="input"
          name= "y"
          value={y}
          onChange={(e) => setY(e.target.value)}
        />
         <label>Coloque a posição Z:</label>
        <input
          className="input"
          name="z"
          value={z}
          onChange={(e) => setZ(e.target.value)}
        />
        <label>Coloque o ângulo X:</label>
        <input
          className="input"
          name="rX"
          value={rX}
          onChange={(e) => setrX(e.target.value)}
        />
        <label>Coloque o ângulo Y:</label>
        <input
          className="input"
          name="rY"
          value={rY}
          onChange={(e) => setrY(e.target.value)}
        />
        <label>Coloque o ângulo Z:</label>
        <input
          className="input"
          name="rZ"
          value={rZ}
          onChange={(e) => setrZ(e.target.value)}
        />
       
        <button onClick={notify()} >
          Enviar posições
        </button>
      </form>
    </div>
  );
};
export default App;
