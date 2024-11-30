import { Link } from "react-router-dom";
import "./Header.css"; // Assuming the CSS above is saved in `Header.css`.

const Header = () => {
  return (
    <header className="header">
      <h1 className="logo">
        <Link to="/">BhopTimer</Link>
      </h1>
      <nav className="top-nav">
        <Link to="/about">About</Link>
        <Link to="https://www.cialloo.com/donate" target="_blank">Donate</Link>
      </nav>
    </header>
  );
};

export default Header;
